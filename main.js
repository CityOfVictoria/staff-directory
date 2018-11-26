import 'es6-promise';
import riot from 'riot';
import 'src/components/staff-directory.tag!';
import focusin from 'focusin';

focusin.polyfill();
riot.mount('staff-directory',{staffsrc:settings.staffSrc});