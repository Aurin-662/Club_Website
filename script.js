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

      // highlight active nav link based on current page/hash
      try {
        var currentHash = location.hash || '';
        var currentPage = (location.pathname.split('/').pop() || 'home.aspx').toLowerCase();
        console.debug('navHighlight currentPage=', currentPage, 'pathname=', location.pathname, 'hash=', location.hash);
        // clear any active flags in header/offcanvas
        document.querySelectorAll('.site-header .active, .offcanvas .active').forEach(function(el){ el.classList.remove('active'); });
        var navLinks = document.querySelectorAll('.site-header .nav-link, .site-header .dropdown-item, .offcanvas .nav-link, .offcanvas .dropdown-item');
        // diagnostic: list nav links (href and classes)
        navLinks.forEach(function(a){
          try{ console.debug('navLink', a.getAttribute('href'), a.className); }catch(e){}
        });
        // when a nav link is clicked, mark it active immediately (before navigation)
        navLinks.forEach(function(a){
          try{
            var rawHref = a.getAttribute('href') || '';
            if(!rawHref || rawHref === '#') return;
            a.addEventListener('click', function(){
              // clear others
              document.querySelectorAll('.site-header .active, .offcanvas .active').forEach(function(el){ el.classList.remove('active'); });
              // mark this one
              a.classList.add('active');
              var dd = a.closest('.dropdown');
              if(dd){
                var toggle = dd.querySelector('.nav-link.dropdown-toggle');
                if(toggle) toggle.classList.add('active');
              }
            }, {capture:true});
          }catch(e){}
        });
        navLinks.forEach(function(a){
          var rawHref = a.getAttribute('href') || '';
          if(!rawHref || rawHref === '#') return;
          try {
            var url = new URL(a.href, location.origin);
            var linkPath = (url.pathname || '').toLowerCase();
            var linkPage = (linkPath.split('/').pop() || '').toLowerCase();
            var linkHash = (url.hash || '').toLowerCase();
            var matched = false;

            // exact hash match
            if(linkHash && linkHash === currentHash.toLowerCase()) matched = true;
            // exact filename match
            else if(linkPage && linkPage === currentPage) matched = true;
            // pathname ends with linkPage (handles virtual directories)
            else if(linkPage && location.pathname.toLowerCase().endsWith(linkPage)) matched = true;
            // raw href equals current hash or path
            else if(rawHref.toLowerCase() === location.hash.toLowerCase()) matched = true;
            else if(rawHref.toLowerCase() === location.pathname.toLowerCase()) matched = true;
            else if(rawHref.toLowerCase() === (location.pathname + location.hash).toLowerCase()) matched = true;

            if(matched) {
              a.classList.add('active');
              var dd = a.closest('.dropdown');
              if(dd){
                var toggle = dd.querySelector('.nav-link.dropdown-toggle');
                if(toggle) toggle.classList.add('active');
              }
              console.debug('navHighlight matched', rawHref, '->', linkPage || linkHash || rawHref);
            }
          } catch(e) { /* ignore parsing errors */ }
        });
      } catch(e) { }
    }catch(e){ console.error('Animation init error', e); }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();
})();
