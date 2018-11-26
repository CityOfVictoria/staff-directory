<refine-field>

    <div tabindex="-1" class="refiner__dropdown" id="refiner">
        <div tabindex="0" onclick="{toggleMenu}">
          <span class="refiner__select">{!opts.value?opts.all:opts.value}</span>
          <span class="icon-arrow_drop_down"></span>        
        </div>

        <ul class="{menuIsOpen?'show':''}">
            <li tabindex="0" class="{(opts.value==opts.all?'selected-refiner':'')}" onclick="{clear}">{opts.all}</li>
            <li tabindex="0" each="{value in opts.values}" class="{(opts.value==value?'selected-refiner':'')}" onclick="{refine}">{value}</li>
        </ul>
    </div>

    <script>
        this.clear = (e) => {
            this.opts.refine(this.opts.field, null);
            this.menuIsOpen = false;
        };
        this.refine = (e) => {
            this.opts.refine(this.opts.field, e.item.value);
            this.menuIsOpen = false;
        }
        
        this.menuIsOpen = false;
        
        this.toggleMenu = (ev) => {
            this.menuIsOpen = !this.menuIsOpen;
        }

        this.elementFocusOut = undefined;
        this.focusout = (ev) => { 
            if (!ev.currentTarget.contains(ev.relatedTarget || document.activeElement)) 
            {
                this.menuIsOpen = false;
                this.update();
            }
            return true;
        }
        this.on('mount', ()=>{
            this.refiner.addEventListener('focusout', this.focusout);
        });
    </script>

</refine-field>
