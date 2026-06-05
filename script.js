// Small animation helpers: reveal on scroll + optional float effect
(function(){
  function onIntersect(entries, obs){
    entries.forEach(function(entry){
      if(entry.isIntersecting){
        entry.target.classList.add('is-visible');
        obs.unobserve(entry.target);
      }
    });
  }

  function init() {
    try{
      var opts = { root: null, rootMargin: '0px 0px -8% 0px', threshold: 0.06 };
      var observer = new IntersectionObserver(onIntersect, opts);
      document.querySelectorAll('.reveal-on-scroll').forEach(function(el){ observer.observe(el); });

      // add floating animation for elements with .float-on-scroll
      document.querySelectorAll('.float-on-scroll').forEach(function(el){ el.classList.add('float-slow'); });

      // small nav behaviour: add shadow when page scrolls
      var header = document.querySelector('.site-header');
      if(header){
        window.addEventListener('scroll', function(){
          if(window.scrollY > 16) header.classList.add('scrolled'); else header.classList.remove('scrolled');
        });
      }

      // nav highlighting is handled centrally in the master page script; do not duplicate here
    }catch(e){ console.error('Animation init error', e); }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();
})();

// Defensive handler: ensure job details links navigate even if other scripts call preventDefault
(function(){
  function onDocClick(e){
    try{
      var t = e.target;
      var a = t.closest && t.closest('a');
      if(!a) return;
      var href = a.getAttribute('href') || a.getAttribute('data-href') || '';
      if(!href) return;
      var low = href.toLowerCase();
      if(low.indexOf('jobdetails.aspx') !== -1){
        console.log('jobdetails click:', href, a.href);
        // allow normal click if navigation already in progress, otherwise force it
        // small timeout to allow other listeners to run; then enforce navigation
        setTimeout(function(){
          try{ window.location.href = a.href; }catch(_){}
        }, 10);
      }
    }catch(err){ console.error('click guard', err); }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function(){ document.addEventListener('click', onDocClick); }); else document.addEventListener('click', onDocClick);
})();
