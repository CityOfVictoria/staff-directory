import { createStore } from 'redux';
import reducer from './state/reducer';
import { getStaffFrom } from './get-data';

export default class app{
    constructor(spec){
        this.store = createStore(reducer);
        
        let s = spec||{}
        this.sources = s.sources || {};
        
        this.store.subscribe(()=>{
            let s = this.store.getState();
            this.departments = s.departments;
            this.divisions = s.divisions;
            this.locations = s.locations;
            
            this.refiners = s.refiners;
            this.searches = s.searches;
            
            this.results = s.results;
            this.requests = s.requests;
        });
    }
    start(){
        this.store.dispatch({type:'request staff'});
        getStaffFrom(this.sources.staff)
        .then((staff)=>{
            this.store.dispatch({type:'receive staff', staff});
        });
    }
    refine(field, value){
        if (!!value){
            this.store.dispatch({
                type:'add refiner',
                refiner: (()=>{let r={}; r[field]=value; return r;})()
            });
        } else {
            this.store.dispatch({
                type:'remove refiner',
                field
            });
        }
    }
    setsearchoption(option){
        this.store.dispatch({type: 'set search field', field: option});       
    }
    query(q){
        this.store.dispatch({type: 'query', query: q});
    }
}