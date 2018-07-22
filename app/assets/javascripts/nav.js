document.addEventListener("turbolinks:load", function(event){
  const navbtn = document.getElementsByClassName('dropdown-btn')[0];

  const showNav = () => {
    const navbar = document.getElementsByClassName('navbar')[0];
    navbar.classList.toggle('show');
    navbar.classList.toggle('mobile-nav');
  };

  navbtn.onclick = () => showNav();
});
