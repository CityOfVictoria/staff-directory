import { createStore } from 'redux';
import reducer from './state/reducer';
import { getStaffFrom } from './get-data';
import { sendContactTo, sendPhotoTo } from './send-data';

function findFirst(array, predicate){
    for(let i=0;i<array.length;i+=1){
        if(!!array[i]&&predicate(array[i])) return array[i];
    }
}

function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

export default class edit{
    constructor(spec){
        this.store = createStore(reducer);
        
        let s = spec||{}
        this.sources = s.sources || {};
        this.endpoints = s.endpoints||{};

        this.staffid = getParameterByName('eid');
        this.subscriptions=[];

        this.store.subscribe(()=>{
            let s = this.store.getState();
            this.departments = s.lookups.department;
            this.divisions = s.lookups.divisionByDepartment;
            this.locations = s.lookups.locationByDepartment;
            this.current = findFirst(s.staff,(c)=>(c.id==this.staffid));
            this.subscriptions.forEach((s)=>s());
        });
    }

    subscribe(fn) {
        this.subscriptions.push(fn);
        return fn;
    }

    start(){
        this.store.dispatch({type:'request staff'});
        getStaffFrom(this.sources.staff)
        .then((staff)=>{
            this.store.dispatch({type:'receive staff', staff});
        });
    }

    save(contact){
        return sendContactTo(contact, this.endpoints.contact)
        .then((contact)=>true)
    }

    uploadPhoto(photoFile){
        return sendPhotoTo(photoFile,this.endpoints.photo)
        .then((photo)=>true);
    }
}