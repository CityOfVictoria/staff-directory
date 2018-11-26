function getViewportRectangle() {
        return {
            top:0,
            left:0,
            bottom: (window.innerHeight || document.documentElement.clientHeight),
            right: (window.innerWidth || document.documentElement.clientWidth)
        };
}

export function isElementInViewport (el) {
    var rect=el.getBoundingClientRect();
    if(!rect) return false;
    
    return (
        rect.bottom > 0 &&
        rect.right > 0 &&
        rect.top < (window.innerHeight || document.documentElement.clientHeight) &&
        rect.left < (window.innerWidth || document.documentElement.clientWidth)
    );
};
    
export function isPercentOfElementInViewport(el, p){
    var rect=el.getBoundingClientRect();
    if(!rect) return false;
    
    var vp = getViewportRectangle();
    
    var visibleWidth = Math.min(rect.right,vp.right) - Math.max(rect.left, vp.left);
    var visibleHeight = Math.min(rect.bottom, vp.bottom) - Math.max(rect.top, vp.top);
    var visibleArea = visibleWidth*visibleHeight;
    var elementArea = (rect.bottom-rect.top)*(rect.right-rect.left);
    
    console.log(JSON.stringify(rect), visibleArea, elementArea);
    return (visibleArea/elementArea) >= p;
};

// export function isPercentOfElementInViewport(el, p){
//     var rect=el.getBoundingClientRect();
//     if(!rect) return false;
    
//     var vp = getViewportRectangle();
    
//     var visibleWidth = Math.min(rect.right,vp.right) - Math.max(rect.left, vp.left);
//     var visibleHeight = Math.min(rect.bottom, vp.bottom) - Math.max(rect.top, vp.top);
//     var visibleArea = visibleWidth*visibleHeight;
//     var elementArea = (rect.bottom-rect.top)*(rect.right-rect.left);
    
//     console.log(JSON.stringify(rect), visibleArea, elementArea);
//     return (visibleArea/elementArea) >= p;
// }

export function getViewportRect(){ return getViewportRectangle(); };