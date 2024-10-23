function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');
    const isOpen = sidebar.classList.contains('open');

    if (isOpen) {
        sidebar.classList.remove('open');
        overlay.classList.remove('open');
        document.querySelector('.main-content').style.marginLeft = '0';
    } else {
        sidebar.classList.add('open');
        overlay.classList.add('open');
        document.querySelector('.main-content').style.marginLeft = '300px';
    }
}



const slider = document.querySelector('.slider');
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;

let index = 0;
let slideInterval;

// Clone the first and last slides to create an infinite loop effect
const firstClone = slides[0].cloneNode(true);
const lastClone = slides[totalSlides - 1].cloneNode(true);

slider.appendChild(firstClone); // Clone the first slide to the end
slider.insertBefore(lastClone, slides[0]); // Clone the last slide to the beginning

// Update the total slide count considering the clones
const allSlides = document.querySelectorAll('.slide');
const totalClones = allSlides.length;

slider.style.transform = `translateX(-100%)`; // Move to the first actual slide (after the last clone)

// Function to move to the next slide
function nextSlide() {
    if (index >= totalSlides - 1) {
        index = 0;
        slider.style.transition = 'none';
        slider.style.transform = `translateX(-100%)`; // Reset to the first actual slide
        setTimeout(() => {
            slider.style.transition = 'transform 0.5s ease-in-out';
            index++;
            slider.style.transform = `translateX(-${(index + 1) * 100}%)`;
        }, 50);
    } else {
        index++;
        slider.style.transform = `translateX(-${(index + 1) * 100}%)`;
    }
}

// Function to move to the previous slide
function prevSlide() {
    if (index <= 0) {
        index = totalSlides - 1;
        slider.style.transition = 'none';
        slider.style.transform = `translateX(-${totalSlides * 100}%)`; // Reset to the last actual slide
        setTimeout(() => {
            slider.style.transition = 'transform 0.5s ease-in-out';
            index--;
            slider.style.transform = `translateX(-${(index + 1) * 100}%)`;
        }, 50);
    } else {
        index--;
        slider.style.transform = `translateX(-${(index + 1) * 100}%)`;
    }
}

// Restart the automatic slide transition when buttons are clicked
function resetSlideInterval() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 3000); // Set the interval to 3 seconds
}

// Event listeners for the buttons
document.querySelector('.prev').addEventListener('click', () => {
    prevSlide();
    resetSlideInterval(); // Reset the timer when the prev button is clicked
});

document.querySelector('.next').addEventListener('click', () => {
    nextSlide();
    resetSlideInterval(); // Reset the timer when the next button is clicked
});

// Initial automatic slide transition
slideInterval = setInterval(nextSlide, 5000);








function toggleDropdown() {
    var dropdown = document.getElementById("dropdown-content");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
}





// Dropdown dışına tıklayınca menüyü kapat
window.onclick = function (event) {
    if (!event.target.matches('.dropdown-toggle')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.style.display === "block") {
                openDropdown.style.display = "none";
            }
        }
    }
}

Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
    // Selectpicker'ı yeniden başlat
    $('.selectpicker').selectpicker('refresh');
});





$(document).ready(function () {
    // Modal içerisindeki enter tuşunu dinle
    $('#login-register-modal').on('keypress', 'input', function (e) {
        if (e.which === 13) { // 13 = Enter tuşu
            e.preventDefault(); // Varsayılan form submit işlemini engelle

            // Login tab aktifse Giriş Yap butonuna tıkla
            if ($('#login').hasClass('active')) {
                $('#<%= GirisButton.ClientID %>').click();
            } 
            // Register tab aktifse Kayıt Ol butonuna tıkla
            else if ($('#register').hasClass('active')) {
                $('#<%= signUpButton.ClientID %>').click();
            }
        }
    });
});



