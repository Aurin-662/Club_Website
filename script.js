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
