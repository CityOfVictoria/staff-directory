import flatten from './flatten';
import sortStaff from './sort-staff.js';
import './vendor/fuse';

function refine(staff, field, value){
    return staff.filter((s)=>(s[field]==value));
}

function peopleOnly(contact){
    return contact.type=='person';
}

const searches = {
    name: {
        keys:['firstName', 'lastName'],
        filters:[peopleOnly]
    },
    firstname:{
        keys:['firstName'],
        filters:[peopleOnly]
    },
    lastname:{
        keys:['lastName'],
        filters:[peopleOnly]
    },
    description:{
        keys:['description'],
        filters:[peopleOnly]
    },
    room:{
        keys:['firstName','lastName'],
        filters:[(contact)=>(contact.type=='room')]
    }
}

export default function searchStaff (staff, refiners, searchtype, query){
    if(!staff || staff.length<1) return [];

    let search = searches[searchtype];
    if(!search) search = searches.name;
    
    let filtered = search.filters.reduce((s, f)=>{
        return s.filter(f);
    }, staff);
    
    let refined = Object.getOwnPropertyNames(refiners||{}).reduce((fd, r)=>{
        return refine(fd, r, refiners[r]);
    }, filtered);
    
    if(!query || !query.trim()) return refined;

    return (new Fuse(refined,{
        keys: search.keys,
        threshold: 0.25,
        tokenize: true,
        sortFn:(l,r)=>{
            if((l.score - r.score) !== 0) return l.score - r.score;
            return sortStaff(l.item,r.item); 
        }
    })).search(query);
}