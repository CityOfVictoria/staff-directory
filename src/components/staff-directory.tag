import App from '../app'; 
import './contact-card.tag!';
import './search-box.tag!'; 
import './refine-field.tag!';
import { isElementInViewport } from '../vendor/element-position';
import stickybits from 'stickybits'

<staff-directory>

    <!-- Search Refiners -->
    <nav class="nav--refiner">
        <div class="row refiners">
            <div class="column span12">

                <!-- start refiner -->
                <div id="refine-person" class="refiner">
                    <span class="refiner__prefix">Show me</span> <search-box query="{query}" chooseoption="{choosesearchoption}"></search-box>
                </div>

                <div id="refine-department" class="refiner"> in
                    <refine-field 
                        field="department" 
                        value="{app.store.getState().refiners.department}" 
                        values="{app.store.getState().lookups.department}" 
                        all="all departments" 
                        refine="{refine}">
                    </refine-field>
                </div>
                <div id="refine-division" class="refiner">
                    <refine-field 
                        field="division" 
                        value="{app.store.getState().refiners.division}" 
                        values="{app.store.getState().lookups.divisionByDepartment[app.store.getState().refiners.department]}" 
                        all="all divisions" 
                        refine="{refine}">
                    </refine-field>
                </div>
                <div id="refine-location-by-dept" class="refiner" each="{(!app.store.getState().refiners.department&&!app.store.getState().refiners.division)?[1]:[]}"> at
                    <refine-field 
                        field="location" value="{app.store.getState().refiners.location}" 
                        values="{app.store.getState().lookups.location}" 
                        all="all locations" refine="{refine}">
                    </refine-field>
                </div>
                <div id="refine-location-by-dept" class="refiner" each="{(app.store.getState().refiners.department&&!app.store.getState().refiners.division)?[1]:[]}">
                    <refine-field 
                        field="location" value="{app.store.getState().refiners.location}" 
                        values="{app.store.getState().lookups.locationByDepartment[app.store.getState().refiners.department]}" 
                        all="all locations" refine="{refine}"
                    </refine-field>
                </div>
                <div id="refine-location-by-div" class="refiner" each="{(app.store.getState().refiners.division)?[1]:[]}">
                    <refine-field 
                        field="location" value="{app.store.getState().refiners.location}" 
                        values="{app.store.getState().lookups.locationByDivision[app.store.getState().refiners.division]}" 
                        all="all locations" refine="{refine}">
                    </refine-field>
                </div>
                <!-- end refiners -->
            </div>
        </div>
    </nav>
    <!-- End Search Refiners -->

    <!-- Search Results -->
    <section class="search-results">
            <contact-card each="{staff in pagedResults}" contact="{staff}"></contact-card>
            <div id="visibility-canary">&nbsp;</div>
            <div class="results-msg results-msg--highlight" if="{(!app.requests.staff && (!app.results||app.results.length===0))}">
                <div class="results-msg__text">
                    <p>Sorry, but we cannot find any results for your search.</p>
                    <p>Suggestions:</p> 
                    <ul>
                        <li>try a partial name search, e.g. "Dav" will return both David and Dave</li>
                        <li>try the first couple letters in first and last names. "Jo Smi" will return John Smith</li>
                        <li>remove any department or location filters</li>
                    </ul>
                </div>
            </div>
            <div class="loader-msg" if="{!!app.requests.staff}">
                <div class="loader-msg__text">searching...</div>
                   <div class="boxloader">
                       <div class="boxloader__box"><i class="fa fa-user"></i></div>
                       <div class="boxloader__box"><i class="fa fa-phone"></i></div>
                       <div class="boxloader__box"><i class="fa fa-at"></i></div>
                       <div class="boxloader__box"><i class="fa fa-comment"></i></div>              
                   </div>
               
            </div>
    </section>
    <!-- End Search Results -->

    <script>
        this.app = new App({
            sources: {
                staff: this.opts.staffsrc
            }
        });
        this.app.store.subscribe(() => {
            this.update();
        });
        this.app.start();
        
        let printResults = () => {
            this.pagedResults = this.app.results;
            this.update();
        }

        let screenResults = () => {
            this.pageReset();
            this.pagedResults=(this.app.results||[]).slice(0,Math.min(this.page * PAGE_SIZE, (this.app.results||[]).length));
            this.update();
        }

        window.onbeforeprint = () => {
           printResults();
        };

        window.onafterprint = () => {
            screenResults();
        }
        
        const PAGE_SIZE=5;
        this.pageReset = () => {
            this.pagedResults = [];
            this.page = 0;
        }
        
        this.checkForNewPage = ()=>{
            if (isElementInViewport(this['visibility-canary']) && (this.page * PAGE_SIZE < (this.app.results||[]).length)) {
                this.page++;
                this.pagedResults=(this.app.results||[]).slice(0,Math.min(this.page * PAGE_SIZE, (this.app.results||[]).length));
                this.update();
            }
        }
        
        this.pageReset();
        
        this.on('mount', ()=> {
            window.addEventListener('scroll',this.checkForNewPage);
            stickybits('.nav--refiner');
        });
        this.on('update', ()=>{
            requestAnimationFrame(()=>{
                this.checkForNewPage();
            });
        });

        this.choosesearchoption = (o) => {
            this.app.setsearchoption(o);
        }
        this.query = (q) => {
            this.pageReset();
            this.app.query(q);
        };

        this.refine = (f, v) => {
            this.pageReset(); 
            if (f == 'department') {
                //division is dependent on department so reset it if department changes
                this.app.refine('division');
                //location is dependent on department so reset it if department changes
                this.app.refine('location');
            }
            if (f == 'division') {
                //location is dependent on division so reset it if division changes
                this.app.refine('location');
            }
            this.app.refine(f, v);
        };
    </script>
</staff-directory>