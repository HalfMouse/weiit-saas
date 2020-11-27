var nav4 =(function(){
	bindClick = function(els, mask){
		if(!els || !els.length){return;}
		var isMobile = "ontouchstart" in window;
		for(var i=0,ci; ci = els[i]; i++){
			ci.addEventListener("click", evtFn, false);
		}

		function evtFn(evt, ci){
			ci =this;
			for(var j=0,cj; cj = els[j]; j++){
				if(cj != ci){
					console.log(cj);
					cj.classList.remove("on");
				}
			}
			if(ci == mask){mask.classList.remove("on");return;}
			switch(evt.type){
				case "click":
					var on = ci.classList.toggle("on");
					mask.classList[on?"add":"remove"]("on");
				break;
			}
		}
		mask.addEventListener(isMobile?"touchstart":"click", evtFn, false);
	}
	return {"bindClick":bindClick};
})();