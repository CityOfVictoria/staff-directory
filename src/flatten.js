export default function flatten(arr, keyselect = (o)=>o.id){
    return arr.reduce((m,i)=>{
        m[keyselect(i)]=i;
        return m;
    },{});
}