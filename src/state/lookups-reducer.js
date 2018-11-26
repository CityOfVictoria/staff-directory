import { unique } from '../unique';

function uniqueLocationByDepartment(staff){
    let t = staff.reduce((u,s)=>{
        if(!s.department || !s.location) return u;
        if(!u[s.department]) u[s.department]={};
        u[s.department][s.location] = 1;
        return u; 
    }, {});
    Object.getOwnPropertyNames(t).forEach((d)=>{ t[d] = Object.getOwnPropertyNames(t[d]).sort(); });
    return t;
}

function uniqueDivisionsByDepartment(staff) {   
    let t = staff.reduce((ud, s)=>{
        if (!s.department || !s.division) return ud;
        if(!ud[s.department]) ud[s.department]=[];
        if(ud[s.department].indexOf(s.division) < 0) ud[s.department].push(s.division);
        return ud;
    },{});
    Object.getOwnPropertyNames(t).forEach((d)=>{ t[d].sort(); });
    return t;
}

function uniqueLocationByDivision(staff){
    let t = staff.reduce((u,s)=>{
        if(!s.division || !s.location) return u;
        if(!u[s.division]) u[s.division]={};
        u[s.division][s.location] = 1;
        return u; 
    }, {});
    Object.getOwnPropertyNames(t).forEach((d)=>{ t[d] = Object.getOwnPropertyNames(t[d]).sort(); });
    return t;
}

export default function lookups(state={}, action){
    switch(action.type){
        case 'receive staff':
            return {
                department: unique(action.staff, 'department').sort(),
                divisionByDepartment: uniqueDivisionsByDepartment(action.staff),
                location: unique(action.staff, 'location').sort(),
                locationByDepartment: uniqueLocationByDepartment(action.staff),
                locationByDivision: uniqueLocationByDivision(action.staff)
            }
        default: return state;
    }
}