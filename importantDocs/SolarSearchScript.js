// ==UserScript==
// @name         SOLAR class search
// @namespace    http://tampermonkey.net/
// @version      0.4
// @description  view class schedules for hidden semesters on SOLAR
// @author       You
// @match        https://prod.ps.stonybrook.edu/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const getSemesterCode = (semester) => {
        const season = semester.split(" ")[0].toLowerCase();
        const year = semester.split(" ")[1];
        const code = season === 'fall' ? 858 : season === 'spring' ? 854 : season === 'winter' ? 851 : 856;
        return code + (10 * (year - 1985));
    }

    const fillInTermDropDown = (select) => {
        while (select.hasChildNodes()) {
            select.removeChild(select.lastChild);
        }
        const options = []
        for (let year = 1985; year < new Date().getFullYear() + 2; year++) {
            let option = document.createElement('option');
            option.appendChild(document.createTextNode(getSemesterCode(`Winter ${year}`)));
            option.value = getSemesterCode(`Winter ${year}`);
            option.innerHTML = `Winter ${year}`;
            options.push(option);

            option = document.createElement('option');
            option.appendChild(document.createTextNode(getSemesterCode(`Spring ${year}`)));
            option.value = getSemesterCode(`Spring ${year}`);
            option.innerHTML = `Spring ${year}`;
            options.push(option);

            option = document.createElement('option');
            option.appendChild(document.createTextNode(getSemesterCode(`Summer ${year}`)));
            option.value = getSemesterCode(`Summer ${year}`)
            option.innerHTML = `Summer ${year}`;
            options.push(option);

            option = document.createElement('option');
            option.appendChild(document.createTextNode(getSemesterCode(`Fall ${year}`)));
            option.value = getSemesterCode(`Fall ${year}`);
            option.innerHTML = `Fall ${year}`;
            options.push(option);
        }
        for (let i = options.length-1; i >= 0; i--) {
            select.appendChild(options[i]);
        }
    }
    if (document.title === 'Class Search') {
        if (window.location.href.includes('psp')) {
            const a = document.getElementById('pthdr2logout');
            a.setAttribute('href', window.location.href.replace('psp', 'psc'));
            a.setAttribute('style', 'font-size: large; border: 10px solid red; background: blue;')
            a.textContent= "SOLAR Class Search Script <CLICK HERE TO USE>";
        } else {
            const select = document.getElementById('CLASS_SRCH_WRK2_STRM$35$');
            select.addEventListener('mousedown', function() {
                fillInTermDropDown(select);
            });
        }
    }
})();