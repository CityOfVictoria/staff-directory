import sortStaff from '../sort-staff.js';
export default function staff(state=[], action) {
    switch(action.type){
        case 'receive staff':
            let s = [...action.staff];
            s.sort(sortStaff);
            return s;
        default: return state;
    }
}