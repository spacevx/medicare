<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6 max-w-4xl">
    <a href="${ctx}/patients" class="inline-flex items-center gap-1.5 text-primary-600 hover:text-primary-800 text-sm font-medium mb-5 transition cursor-pointer">
        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour aux patients
    </a>

    <div class="flex items-center gap-4 mb-6">
        <div class="w-12 h-12 bg-primary-100 rounded-full flex items-center justify-center">
            <i data-lucide="user" class="w-6 h-6 text-primary-700"></i>
        </div>
        <div>
            <h2 class="text-xl font-bold text-primary-900">${patient.nomComplet}</h2>
            <p class="text-sm text-surface-300">N. Secu: ${patient.numeroSecu} -- Ne(e) le ${patient.dateNaissance}</p>
        </div>
        <div class="ml-auto">
            <c:choose>
                <c:when test="${patient.etatSante == 'Critique'}">
                    <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-sm font-semibold bg-danger-50 text-danger-700 border border-danger-100">
                        <span class="w-2 h-2 rounded-full bg-danger-500"></span> ${patient.etatSante}
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-sm font-semibold bg-accent-50 text-accent-700 border border-accent-100">
                        <span class="w-2 h-2 rounded-full bg-accent-500"></span> ${patient.etatSante}
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="grid grid-cols-3 gap-4 mb-6">
        <div class="bg-white rounded-xl border border-surface-200 p-4 text-center">
            <p class="text-2xl font-bold text-primary-900 tabular-nums">${patient.dossierMedical.size()}</p>
            <p class="text-xs font-semibold text-surface-300 uppercase tracking-wider mt-1">Soins</p>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-4 text-center">
            <p class="text-2xl font-bold text-primary-900 tabular-nums">${patient.antecedents.size()}</p>
            <p class="text-xs font-semibold text-surface-300 uppercase tracking-wider mt-1">Antecedents</p>
        </div>
        <div class="bg-white rounded-xl border border-surface-200 p-4 text-center">
            <p class="text-2xl font-bold text-primary-900 tabular-nums">${String.format("%.0f", patient.calculerCout())} EUR</p>
            <p class="text-xs font-semibold text-surface-300 uppercase tracking-wider mt-1">Cout total</p>
        </div>
    </div>

    <div class="grid grid-cols-2 gap-5">
        <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
            <div class="px-5 py-3 border-b border-surface-200 bg-surface-50 flex items-center justify-between">
                <h3 class="text-sm font-bold text-primary-900">Antecedents medicaux</h3>
            </div>

            <div class="p-5">
                <form method="post" action="${ctx}/patients" class="flex gap-2 mb-4">
                    <input type="hidden" name="action" value="addAntecedent">
                    <input type="hidden" name="id" value="${patient.id}">
                    <input type="text" name="antecedent" placeholder="Ajouter un antecedent..." required
                           class="flex-1 border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                    <button type="submit" class="inline-flex items-center gap-1 bg-primary-600 text-white px-3 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer">
                        <i data-lucide="plus" class="w-3.5 h-3.5"></i> Ajouter
                    </button>
                </form>

                <c:if test="${not empty patient.antecedents}">
                    <ul class="space-y-2">
                        <c:forEach var="ant" items="${patient.antecedents}" varStatus="st">
                            <li class="flex items-center gap-2 text-sm text-primary-800">
                                <span class="w-5 h-5 bg-warn-50 rounded flex items-center justify-center shrink-0">
                                    <i data-lucide="file-text" class="w-3 h-3 text-warn-600"></i>
                                </span>
                                ${ant}
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty patient.antecedents}">
                    <p class="text-sm text-surface-300 text-center py-4">Aucun antecedent enregistre</p>
                </c:if>
            </div>
        </div>

        <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
            <div class="px-5 py-3 border-b border-surface-200 bg-surface-50">
                <h3 class="text-sm font-bold text-primary-900">Historique des soins</h3>
            </div>

            <c:if test="${not empty patient.dossierMedical}">
                <div class="divide-y divide-surface-100">
                    <c:forEach var="soin" items="${patient.dossierMedical}">
                        <div class="px-5 py-3.5">
                            <div class="flex items-center justify-between mb-1">
                                <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-semibold
                                    ${soin.type == 'Consultation' ? 'bg-accent-50 text-accent-700' : 'bg-warn-50 text-warn-600'}">
                                    ${soin.type}
                                </span>
                                <span class="text-sm font-semibold text-primary-900 tabular-nums">${soin.cout} EUR</span>
                            </div>
                            <p class="text-sm text-primary-800">${soin.description}</p>
                            <p class="text-xs text-surface-300 mt-1">Dr. ${soin.medecin.nomComplet} -- ${soin.date}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty patient.dossierMedical}">
                <div class="px-5 py-12 text-center text-surface-300 text-sm">Aucun soin enregistre</div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
