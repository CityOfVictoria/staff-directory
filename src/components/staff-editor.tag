import Edit from '../edit';
import './edit-contact.tag!';

<staff-editor>
    <div>
        <edit-contact
            contact="{edit.current}"
            departments="{edit.departments}"
            divisions="{edit.divisions}"
            locations="{edit.locations}"
            photosurl="{opts.photosurl}"
            save="{s}"
            uploadphoto="{p}"
        ></edit-contact>
    </div>
    <script>
        this.edit = new Edit({
            sources: {
                staff: this.opts.staffsrc
            },
            endpoints: {
                contact: this.opts.savecontact,
                photo: this.opts.savephoto
            }
        });
        this.edit.subscribe(() => {
            this.update();
        });

        this.s = (c)=>this.edit.save(c);
        this.p = (p)=>this.edit.uploadPhoto(p);
        this.edit.start();
    </script>
</staff-editor>