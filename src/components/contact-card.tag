import { isElementInViewport } from '../vendor/element-position';

<contact-card>

    <div class="employee-card">
        <div class="employee-card__photo">
            <div if="{!!opts.contact.photo}" class="color-block">
                <div class="color-block-content">
                    <div id="employee-img" class="staff-portrait"></div>
                </div>
            </div> 
            <div if="{!opts.contact.photo}" class="no-picture">
                <div class="color-block">
                    <div class="color-block-content">
                        <div class="thumbnail-initials">{staff.firstName[0]}{staff.lastName[0]}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="employee-card__content">
            <header class="employee-card__header">
                <h2>{opts.contact.firstName} {opts.contact.lastName}</h2>
                <a class="changelink" href="mailto:{editoremail}?subject=Staff%20Directory%20Change%20Request%20for%20{opts.contact.firstName}%20{opts.contact.lastName}&body={editorbody}{opts.contact.id}">Request Update</a>
            </header>
            
            <div class="employee-card__main">
                <div class="employee-card__details">
                    <ul>
                        <li if="{!!opts.contact.title}" class="emp-title"><span>{opts.contact.title}</span></li> 
                        <li if="{!!opts.contact.division}"><span class="emp-div">{opts.contact.division}</span></li>
                        <li if="{!!opts.contact.department}"><span class="emp-dept">{opts.contact.department}</span></li>

                        <!-- <li if="{!!opts.contact.section}"><span class="emp-section">{(opts.contact.section[0]!='_')?opts.contact.section:''}</span></li> -->
                        <li>{opts.contact.location}</li>
                    </ul>
                </div>
                <div class="employee-card__contacts">
                    <ul>
                        <li if="{!!opts.contact.phone && opts.contact.phone.length == 4}"><span class="icon-phone"></span> x{opts.contact.phone}</li>
                        <li if="{!!externalPhone}">
                            <a href="tel:{externalPhone}">
                                <span class="icon-phone"></span>
                                <span class="emp-detail-link">{externalPhone}</span>
                            </a>
                        </li>

                        <li if="{!!mobilePhone}">
                            <a href="tel:{mobilePhone}">
                                <span class="icon-mobile"></span>
                                <span class="emp-detail-link">{mobilePhone}</span>
                            </a>
                        </li>
                        <li if="{!!opts.contact.email}">
                            <a href="mailto:{opts.contact.email}">
                                <span class="icon-envelope"></span>
                                <span class="emp-detail-link">{opts.contact.email}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <script>
        var imageLoaded = false;
        
        this.editoremail = settings.editor.email;
        this.editorbody = encodeURIComponent('What changes do you want?\n=========================\n\n\n\n\n=========================\n\nThank you!\n\nFOR OFFICE USE ONLY: '+settings.editor.url+'?eid=');

        function stripPhoneNumber(number){
            return (number||'').replace(/[^\d+]/g,'');
        }
        
       function formatPhoneNumber(number) {   
            if (number.length === 10){
                return number.substring(0,3) + '-' + number.substring(3,6) + '-' + number.substring(6);
            } else {return number;}
        }
        
        this.checkForImageDraw = (()=>{
            if(isElementInViewport(this['employee-img']) && !imageLoaded) {
				if(this.opts.contact.photo){
					this['employee-img'].style.backgroundImage = 'url("'+settings.photosPath+this.opts.contact.photo+'")';
				} else {
					this['employee-img'].style.backgroundImage = '';
				}
				imageLoaded=true;
			}
        });
        
        this.on('update', (() => {
            this.externalPhone = formatPhoneNumber(stripPhoneNumber(this.opts.contact.externalphone));
            
            if(this.opts.contact.mobile){
                this.mobilePhone = formatPhoneNumber(stripPhoneNumber(this.opts.contact.mobile));
            };

            setTimeout(()=>{
				requestAnimationFrame(()=>{
					this.checkForImageDraw();
				});	
			}, 500);
            
        }).bind(this));
        
        window.addEventListener('scroll',this.checkForImageDraw);
		this.checkForImageDraw();
    </script>
</contact-card>
