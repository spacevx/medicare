<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="mb-5">
        <h2 class="text-xl font-bold text-primary-900">File d'attente -- Urgences</h2>
        <p class="text-sm text-surface-300 mt-0.5">Actes chirurgicaux tries par priorite medicale</p>
    </div>

    <div class="grid grid-cols-3 gap-4 mb-6">
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-danger-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-danger-50 rounded-lg flex items-center justify-center">
                    <i data-lucide="alert-triangle" class="w-5 h-5 text-danger-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Actes critiques</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${actesCritiques.size()}</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-warn-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-warn-50 rounded-lg flex items-center justify-center">
                    <i data-lucide="clock" class="w-5 h-5 text-warn-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">En attente</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${fileUrgences.taille()}</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-5 relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-1 bg-primary-500"></div>
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-primary-50 rounded-lg flex items-center justify-center">
                    <i data-lucide="users" class="w-5 h-5 text-primary-600"></i>
                </div>
                <div>
                    <p class="text-[11px] font-semibold text-surface-300 uppercase tracking-wider">Patients critiques</p>
                    <p class="text-2xl font-bold text-primary-900 tabular-nums">${patientsUrgents.size()}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-2 gap-5">
        <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
            <div class="px-5 py-3 border-b border-surface-200 bg-surface-50">
                <h3 class="text-sm font-bold text-primary-900">Actes critiques (priorite haute)</h3>
            </div>
            <c:if test="${not empty actesCritiques}">
                <div class="divide-y divide-surface-100">
                    <c:forEach var="acte" items="${actesCritiques}">
                        <div class="px-5 py-3.5 flex items-center justify-between">
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold
                                        ${acte.niveauUrgence >= 4 ? 'bg-danger-50 text-danger-700 border border-danger-100' : 'bg-warn-50 text-warn-600 border border-warn-100'}">
                                        Niveau ${acte.niveauUrgence}/5
                                    </span>
                                    <span class="text-sm font-semibold text-primary-900">${acte.description}</span>
                                </div>
                                <p class="text-xs text-surface-300">Dr. ${acte.medecin.nomComplet} -- Salle ${acte.salle}</p>
                            </div>
                            <span class="text-sm font-semibold text-primary-900 tabular-nums">${acte.cout} EUR</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty actesCritiques}">
                <div class="px-5 py-12 text-center text-surface-300 text-sm">Aucun acte critique en attente</div>
            </c:if>
        </div>

        <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
            <div class="px-5 py-3 border-b border-surface-200 bg-surface-50">
                <h3 class="text-sm font-bold text-primary-900">Patients en etat critique</h3>
            </div>
            <c:if test="${not empty patientsUrgents}">
                <div class="divide-y divide-surface-100">
                    <c:forEach var="p" items="${patientsUrgents}">
                        <div class="px-5 py-3.5 flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-danger-50 rounded-full flex items-center justify-center">
                                    <i data-lucide="user" class="w-4 h-4 text-danger-600"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-semibold text-primary-900">${p.nomComplet}</p>
                                    <p class="text-xs text-surface-300">N. Secu: ${p.numeroSecu}</p>
                                </div>
                            </div>
                            <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold bg-danger-50 text-danger-700 border border-danger-100">
                                <span class="w-1.5 h-1.5 rounded-full bg-danger-500"></span> ${p.etatSante}
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty patientsUrgents}">
                <div class="px-5 py-12 text-center text-surface-300 text-sm">Aucun patient critique</div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
