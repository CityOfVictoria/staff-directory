<search-box>
    <div class="refiner__dropdown" tabindex="-1" id="searchtype">
        <div onclick="{toggleMenu}">
            <span class="refiner__select">{searchoptions[selectedoption]}</span>
            <span class="icon-arrow_drop_down"></span>
        </div>

        <ul class="{menuIsOpen?'show':''}">
            <li each="{k,v in searchoptions}" class="refiner-option {(selectedoption==k)?'selected-refiner':''}" onclick="{chooseoption}">{v}</li>
        </ul>
    </div>
    <input type="text" oninput="{query}" placeholder="Enter Name" id="name-search" class="refiner__input-box" autofocus>

    <script>
        this.searchoptions = {
            name: 'people named',
            firstname: 'people with first name',
            lastname: 'people with last name',
            room: 'rooms called'
        };
        this.selectedoption = 'name';
        this.opts.chooseoption('name');

        let search = () => {
            this.opts.query(this['name-search'].value);
            //if (!!this['name-search'].value) this.opts.query(this['name-search'].value);
        }
        
        this.chooseoption = (e) => {
            this.selectedoption = e.item.k;
            this.opts.chooseoption(this.selectedoption);
            this.menuIsOpen = false;
            requestAnimationFrame(search);
        };

        let queryTimeout;
        this.query = (e) => {
            if (!!queryTimeout) clearTimeout(queryTimeout);
            queryTimeout = setTimeout(search, 500);
        };
        
        this.menuIsOpen = false;

        this.toggleMenu = (ev) => {
            this.menuIsOpen = !this.menuIsOpen;
        }
        this.focusout = (ev) => {
            //debugger; 
            if (!ev.currentTarget.contains(ev.relatedTarget || document.activeElement)) 
            {
                this.menuIsOpen = false;
                this.update();
            }
            return true;
        }
        this.on('mount',()=>{
            this.searchtype.addEventListener('focusout', this.focusout);
        });
    </script>
</search-box>
