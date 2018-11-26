import 'es6-promise';
import riot from 'riot';
import 'src/components/staff-editor.tag!';
import focusin from 'focusin';

focusin.polyfill();
riot.mount('staff-editor', {
    staffsrc: settings.staffSrc,
    savecontact: settings.editor.save.contact,
    savephoto: settings.editor.save.photo
});
