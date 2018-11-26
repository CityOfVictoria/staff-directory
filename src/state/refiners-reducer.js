export default function refiners(state={}, action){
    switch(action.type){
        case 'add refiner':
            return Object.assign({},state,action.refiner);
        case 'remove refiner':
            let s = Object.assign({},state);
            delete s[action.field];
            return s;
        default: return state;
    }
}