---
layout: default
title: Team
teamnames:
    - Aleksander Holynski
    - Edward Zhang
    - Hamid Izadinia
    - Keunhong Park
imageurls:
    - http://grail.cs.washington.edu/wp-content/uploads/2015/08/holynski.jpg
    - http://grail.cs.washington.edu/wp-content/uploads/2015/08/edzhang.jpg
    - http://grail.cs.washington.edu/wp-content/uploads/2015/09/HamidIzadinia.jpg
    - http://grail.cs.washington.edu/wp-content/uploads/2015/10/kpar.jpg
descriptions:
    - >
        Second-year PhD student in CSE at the University of Washington
    - >
        Third-year PhD student in CSE at the University of Washington
    - >
        Third-year PhD student in CSE at the University of Washington
    - >
        First-year PhD student in CSE at the University of Washington
customstyles: 
    - team.css
---

<table id="team">
{% for name in page.teamnames %}
    <tr>
        <td>
            <h2 class="membername">{{ name }}</h2>
            <div class="memberdesc">{{ page.descriptions[forloop.index0] }}</div>
        </td>
        <td>
            <img class="memberimage" src="{{ page.imageurls[forloop.index0]}}" />
        </td>
    </tr>
{% endfor %}
</table>
