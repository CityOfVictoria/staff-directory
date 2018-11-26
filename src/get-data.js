import ajax from './vendor/ajaxpoop';
import fixStaffData from './fixStaffData';

export function getStaffFrom(src){
    return ajax(src).header('Cache-Control','NO-CACHE').get()
	.then(function(xhr){
		return JSON.parse(xhr.response).map(fixStaffData);
	});
}

export function getLookupDataFrom(src){
    return ajax(src).get()
	.then((xhr)=>JSON.parse(xhr.response));
}