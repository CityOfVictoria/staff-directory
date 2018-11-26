export function unique(arrayOfObjects,key, includenulls){
    return arrayOfObjects.reduce((u, v)=>{
        if(!includenulls && !v[key]) return u; //reject the value if rejecting nulls
        if(u.indexOf(v[key]) < 0) return [...u,v[key]];
        return u;
    },[]);
}
