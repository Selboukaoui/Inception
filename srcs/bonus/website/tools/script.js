
var i = 0;

function openSideBar() {
    if (i % 2 == 0)
    {
        document.getElementById("active").style.visibility = "hidden";
        document.getElementsByClassName("content")[0].style.visibility = "visible"
        i = 0;
    }
    else
    {
        document.getElementById("active").style.visibility = "visible";
        document.getElementsByClassName("content")[0].style.visibility = "hidden";
    }
    i++;
}

window.addEventListener("resize", function(event) {
    if (document.body.clientWidth > 680)
    {
        document.getElementById("active").style.visibility = "visible";
        document.getElementsByClassName("content")[0].style.visibility = "visible";
    }
    else
    {
        document.getElementById("active").style.visibility = "hidden";
    }
})
