export default function requests(state={}, action) {
    switch(action.type){
        case 'request staff':
            return Object.assign({}, state, {staff:true});
        case 'receive staff':
            let sc = Object.assign({}, state, {staff:false});
            delete sc.staff;
            return sc;
        default: return state;
    }
}