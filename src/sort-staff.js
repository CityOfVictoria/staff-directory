export default function (l,r){
    if(!(l.firstName && l.lastName) && (r.firstName && r.lastName)) return 1;
    if((l.firstName && l.lastName) && !(r.firstName && r.lastName)) return -1;

    if(l.firstName < r.firstName) return -1;
    if(l.firstName > r.firstName) return 1;
    if(l.lastName < r.lastName) return -1;
    if(l.lastName > r.lastName) return 1;
    return 0;
};