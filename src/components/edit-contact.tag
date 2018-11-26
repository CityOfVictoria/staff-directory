import loadImage from '../vendor/load-image';

<edit-contact>
    <style>
        .photo {
            border: solid gray 1px;
            min-width:75;
            min-height:75;
            cursor:pointer;
        }

        .big-input {
            font-size: 4em;
        }
    </style>
    <div class="edit-contact__row">
        <label for="type" class="label" >Contact Type</label>
        <select class="field" name="type" id="type" oninput="{oninput}">
            <option selected="{contact.type=='person'}">person</option>
            <option selected="{contact.type=='room'}">room</option>
            <option selected="{contact.type=='fax'}">fax</option>
            <option selected="{contact.type=='general'}">general</option>
        </select>
    </div>

    <div class="edit-contact__row">
        <label for="labelName" class="label">First Name</label>
        <input class="big-input field" type="text" class="field" name="firstName" id="firstName" oninput="{oninput}">
    </div>

    <div class="edit-contact__row">
        <label for="lastName" class="label">Last Name</label>
        <input class="big-input field" type="text" name="lastName" id="lastName" oninput="{oninput}">
    </div>

    <div class="edit-contact__row">
        <label for="mug" class="label">Photo</label>
        <div onclick="{chooseimage}" class="field photo"><img src="{photo}" id="mug">&nbsp;</div>
        <button onclick="{removePhoto}">Remove</button>
    </div>
    <div class="edit-contact__row">
        <label for="department" class="label">Department</label>
        <select class="field" name="department" id="department" oninput="{oninput}">
            <option each="{d in opts.departments}" selected="{d==contact.department}">{d}</option>
        </select>
        <button data-select="department" onclick="{newSelectValue}">New</button>
    </div>

    <div class="edit-contact__row">
        <label for="division" class="label">Division</label>
        <select class="field" name="division" id="division" oninput="{oninput}">
            <option each="{d in opts.divisions[contact.department]}" selected="{d==contact.division}">{d}</option>
        </select>
        <button data-select="division" onclick="{newSelectValue}">New</button>
    </div>

    <div class="edit-contact__row">
        <label for="title" class="label">Title</label>
        <input class="field" type="text" name="title" id="title" oninput="{oninput}">
    </div>

    <div class="edit-contact__row">
        <label for="location" class="label">Location</label>
        <select class="field" name="location" id="location" oninput="{oninput}">
            <option each="{l in opts.locations[contact.department]}" selected="{l==contact.location}">{l}</option>
        </select>
        <button data-select="location" onclick="{newSelectValue}">New</button>
    </div>

    <div class="edit-contact__row">
        <label for="phone" class="label">Local</label>
        <input type="tel" class="field" name="phone" id="phone" oninput="{oninput}">
    </div>

    <div class="edit-contact__row">
        <label for="mobile" class="label">Mobile</label>
        <input type="tel" class="field" name="mobile" id="mobile" oninput="{oninput}">
    </div>

    <div class="edit-contact__row">
        <label for="email" class="label">E Mail</label>
        <input type="email" class="field" name="email" id="email" oninput="{oninput}">
    </div>
    <input type="file" accept="image/*" name="itemphoto" id="itemphoto" ref="itemphoto" style="display:none" />


    <button onclick="{save}" disabled="{canSave}">SAVE</button>

    <script>
        this.oninput = (e)=>{
            let i = e.currentTarget.id;
            if(i) this.contact[i]=e.currentTarget.value;
        };

        this.chooseimage = (e)=>this.itemphoto.click();
        this.removePhoto = (e)=>{
            this.itemphoto.value=null;
            if(navigator.userAgent.indexOf('irefox') > -1) this.itemphoto.dispatchEvent(new Event('change'));
        };

        this.newSelectValue = (e)=>{
            let targetSelect = e.currentTarget.dataset.select;
            if (!targetSelect) return;
            let newValue = prompt('Enter new:','');
            let s = document.getElementById(targetSelect);
            let opt = document.createElement('option');
            opt.value = newValue;
            opt.innerHTML = newValue;
            opt.selected = 'selected';
            s.appendChild(opt);
        }

        this.save = ()=>{
            this.uploadPhoto()
            .then(this.saveContact)
            .then(this.update);
        }

        this.saveContact = ()=>{
            //return saving promise
            return this.opts.save(this.contact);
        }
        this.uploadPhoto = ()=>{
            //don't return anything useful if no photo
            if(!this.photofile) return (new Promise((r,x)=>r(true)));
            //return upload promise
            return this.opts.uploadphoto(this.photofile);
        }

        this.canSave = false;

        this.on('update',()=>{
            if(!this.opts.contact) return;
            this.original = this.opts.contact;
            //only update data if the actual contact has changed
            if(!this.contact || this.opts.contact.id!=this.contact.id){
                this.contact = Object.assign({},this.opts.contact);
                Object.getOwnPropertyNames(this.contact).forEach((pn)=>{
                    if(this[pn]) this[pn].value=this.contact[pn];
                });
                this.photo=(this.contact&&this.contact.photo)||'https://broken-garbage-dummy-url-'+Date.now();
            }
            if(this.contact && this.opts.contact) this.canSave = Object.getOwnPropertyNames(this.opts.contact).reduce((r,pn)=>{
                return r && (this.opts.contact[pn]==this.contact[pn]);
            }, true);
        });

        this.on('mount',()=>{
            this.itemphoto.addEventListener('change',(e)=>{
                this.photofile = e.currentTarget.files[0];
                if (!!this.photofile){
                    debugger;
                    this.contact.photo = (this.opts.photosurl||'')+'/'+this.photofile.name;
                    loadImage(this.photofile).then((p)=>{
                        this.photo=p;
                        this.update();
                    });
                } else {
                    this.contact.photo = undefined;
                    this.photo = 'https://broken-garbage-dummy-url-'+Date.now();
                }
            });
        });
    </script>
</edit-contact>