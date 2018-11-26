export default function searches(state={}, action){
    switch(action.type){
        case 'set search field':
            return Object.assign({},state,{ field: action.field });
        case 'query':
            return Object.assign({},state,{ query: action.query });
        default: return state;
    }
}