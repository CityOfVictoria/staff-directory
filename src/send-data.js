import ajax from './vendor/ajaxpoop';
import fixStaffData from './fixStaffData';

export function sendContactTo(contact, to){
    let staffData = 'data='+encodeURIComponent(JSON.stringify(contact));
    return ajax(to).withCred(true).header('Content-Type','application/x-www-form-urlencoded;charset=UTF-8').errorOn((xhr)=>(xhr.status>399)).post(staffData)
    .then((xhr)=>fixStaffData(JSON.parse(xhr.response)));
}

export function sendPhotoTo(photo,to){
    let formData = new FormData();
    formData.append('photo', photo);
    return ajax(to).withCred(true).header('Content-Type','image').errorOn((xhr)=>(xhr.status>399)).post(formData)
    .then((xhr)=>true);
}