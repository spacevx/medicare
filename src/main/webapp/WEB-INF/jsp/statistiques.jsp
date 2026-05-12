<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="mb-6">
        <h2 class="text-xl font-bold text-primary-900">Tableau de bord</h2>
        <p class="text-sm text-surface-300 mt-0.5">Vue d'ensemble de l'activite hospitaliere</p>
    </div>

    <div class="grid grid-cols-4 gap-4 mb-7">
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-primary-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-primary-50 rounded-lg flex items-center justify-center shrink-0">
                    <i data-lucide="users" class="w-5 h-5 text-primary-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Total Patients</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${totalPatients}</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-accent-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-accent-50 rounded-lg flex items-center justify-center shrink-0">
                    <i data-lucide="log-in" class="w-5 h-5 text-accent-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Patients Admis</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${patientsAdmis}</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-warn-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-warn-50 rounded-lg flex items-center justify-center shrink-0">
                    <i data-lucide="banknote" class="w-5 h-5 text-warn-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Cout Moyen</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${String.format("%.0f", coutMoyen)} EUR</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-danger-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-danger-50 rounded-lg flex items-center justify-center shrink-0">
                    <i data-lucide="bed-double" class="w-5 h-5 text-danger-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Occupation</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${String.format("%.0f", tauxOccupation)}%</p>
                </div>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-2 gap-5 mb-5">
        <div class="bg-white rounded-xl border border-surface-200 p-5">
            <h3 class="text-sm font-bold text-primary-900 mb-4">Patients par etat</h3>
            <div class="h-56"><canvas id="chartEtat"></canvas></div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5">
            <h3 class="text-sm font-bold text-primary-900 mb-4">Soins par medecin</h3>
            <div class="h-56"><canvas id="chartMedecins"></canvas></div>
        </div>
    </div>

    <c:if test="${not empty salles}">
        <div class="bg-white rounded-xl border border-surface-200 p-5">
            <h3 class="text-sm font-bold text-primary-900 mb-4">Occupation des salles</h3>
            <div class="h-40"><canvas id="chartSalles"></canvas></div>
        </div>
    </c:if>
</div>

<script>
    const C = { cyan:'#0891b2', green:'#059669', red:'#dc2626', amber:'#d97706', purple:'#7c3aed', teal:'#0d9488' };
    const opts = { responsive:true, maintainAspectRatio:false, plugins:{ legend:{ labels:{ font:{ family:'Figtree', size:12 }, usePointStyle:true, pointStyle:'circle' } } } };

    const etatData = { <c:forEach var="e" items="${patientsParEtat}" varStatus="st">'${e.key}':${e.value}${!st.last?',':''}</c:forEach> };
    if (Object.keys(etatData).length) {
        new Chart(document.getElementById('chartEtat'), {
            type:'doughnut',
            data:{ labels:Object.keys(etatData), datasets:[{ data:Object.values(etatData), backgroundColor:[C.green,C.red,C.amber,C.cyan,C.purple], borderWidth:0 }] },
            options:{ ...opts, cutout:'65%', plugins:{ ...opts.plugins, legend:{ ...opts.plugins.legend, position:'bottom' } } }
        });
    }

    const medData = { <c:forEach var="e" items="${soinsParMedecin}" varStatus="st">'${e.key}':${e.value}${!st.last?',':''}</c:forEach> };
    if (Object.keys(medData).length) {
        new Chart(document.getElementById('chartMedecins'), {
            type:'bar',
            data:{ labels:Object.keys(medData), datasets:[{ data:Object.values(medData), backgroundColor:C.cyan, borderRadius:6, barPercentage:0.5 }] },
            options:{ ...opts, plugins:{ legend:{ display:false } }, scales:{ y:{ beginAtZero:true, ticks:{ stepSize:1, font:{ family:'Figtree' } } }, x:{ ticks:{ font:{ family:'Figtree', size:11 } } } } }
        });
    }

    <c:if test="${not empty salles}">
    new Chart(document.getElementById('chartSalles'), {
        type:'bar',
        data:{
            labels:[<c:forEach var="s" items="${salles}" varStatus="st">'Salle ${s.numero}'${!st.last?',':''}</c:forEach>],
            datasets:[{ data:[<c:forEach var="s" items="${salles}" varStatus="st">${Math.round(s.tauxOccupation)}${!st.last?',':''}</c:forEach>],
                backgroundColor:[<c:forEach var="s" items="${salles}" varStatus="st">${s.tauxOccupation>80?"'#dc2626'":s.tauxOccupation>50?"'#d97706'":"'#059669'"}${!st.last?',':''}</c:forEach>],
                borderRadius:6, barPercentage:0.4 }]
        },
        options:{ ...opts, indexAxis:'y', plugins:{ legend:{ display:false } }, scales:{ x:{ max:100, beginAtZero:true, ticks:{ font:{ family:'Figtree' } } }, y:{ ticks:{ font:{ family:'Figtree', size:12 } } } } }
    });
    </c:if>
</script>

<jsp:include page="includes/footer.jsp"/>
