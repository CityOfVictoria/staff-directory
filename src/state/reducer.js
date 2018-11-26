import '../vendor/object.assign';
import lookups from './lookups-reducer';
import refiners from './refiners-reducer';
import searches from './searches-reducer';
import staff from './staff-reducer';
import requests from './request-reducer';
import {combineReducers} from 'redux';

import searchStaff from '../search-staff';

var basicReducer = combineReducers({
    staff, refiners, searches, lookups, requests
});

export default function reducer(state={}, action){
    let s = basicReducer(state, action);
    s.results = searchStaff(s.staff,s.refiners,s.searches.field, s.searches.query);
    return s;
}