<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="flex items-center justify-between mb-5">
        <div>
            <h2 class="text-xl font-bold text-primary-900">Salles et Lits</h2>
            <p class="text-sm text-surface-300 mt-0.5">Occupation et gestion des chambres</p>
        </div>
        <a href="${ctx}/salles?action=form"
           class="inline-flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer">
            <i data-lucide="plus" class="w-4 h-4"></i> Nouvelle Salle
        </a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-5">
        <c:forEach var="s" items="${salles}">
            <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
                <div class="h-1 ${s.tauxOccupation > 80 ? 'bg-danger-500' : s.tauxOccupation > 50 ? 'bg-warn-500' : 'bg-accent-500'}"></div>
                <div class="p-5">
                    <div class="flex items-start justify-between mb-4">
                        <div>
                            <h3 class="text-base font-bold text-primary-900">Salle ${s.numero}</h3>
                            <span class="inline-flex px-2 py-0.5 rounded-full text-[11px] font-semibold bg-primary-50 text-primary-700 border border-primary-200 mt-1">${s.type}</span>
                        </div>
                        <form method="post" action="${ctx}/salles" onsubmit="return confirm('Supprimer cette salle ?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${s.id}">
                            <button title="Supprimer" class="p-1.5 rounded-md hover:bg-danger-50 text-danger-500 transition cursor-pointer">
                                <i data-lucide="trash-2" class="w-4 h-4"></i>
                            </button>
                        </form>
                    </div>

                    <div class="grid grid-cols-3 gap-3 mb-4">
                        <div class="text-center p-2 bg-surface-50 rounded-lg">
                            <div class="text-lg font-bold text-primary-900">${s.patientsPresents.size()}</div>
                            <div class="text-[10px] font-semibold text-surface-300 uppercase">Occupes</div>
                        </div>
                        <div class="text-center p-2 bg-accent-50 rounded-lg">
                            <div class="text-lg font-bold text-accent-600">${s.litsDisponibles}</div>
                            <div class="text-[10px] font-semibold text-surface-300 uppercase">Libres</div>
                        </div>
                        <div class="text-center p-2 bg-surface-50 rounded-lg">
                            <div class="text-lg font-bold text-primary-700">${s.capacite}</div>
                            <div class="text-[10px] font-semibold text-surface-300 uppercase">Total</div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="flex justify-between text-[11px] font-medium text-surface-300 mb-1">
                            <span>Occupation</span>
                            <span>${Math.round(s.tauxOccupation)}%</span>
                        </div>
                        <div class="w-full bg-surface-100 rounded-full h-1.5">
                            <div class="h-1.5 rounded-full transition-all ${s.tauxOccupation > 80 ? 'bg-danger-500' : s.tauxOccupation > 50 ? 'bg-warn-500' : 'bg-accent-500'}"
                                 style="width: ${s.tauxOccupation}%"></div>
                        </div>
                    </div>

                    <c:if test="${s.litsDisponibles > 0 && not empty patientsAdmis}">
                        <form method="post" action="${ctx}/salles" class="flex gap-2 mb-3">
                            <input type="hidden" name="action" value="affecter">
                            <input type="hidden" name="salleId" value="${s.id}">
                            <select name="patientId" class="flex-1 border border-surface-200 rounded-lg px-2 py-1.5 text-xs bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                                <c:forEach var="p" items="${patientsAdmis}">
                                    <option value="${p.id}">${p.nomComplet}</option>
                                </c:forEach>
                            </select>
                            <button class="inline-flex items-center gap-1 bg-accent-600 text-white px-2.5 py-1.5 rounded-lg hover:bg-accent-700 transition text-xs font-semibold cursor-pointer">
                                <i data-lucide="user-plus" class="w-3 h-3"></i> Affecter
                            </button>
                        </form>
                    </c:if>

                    <c:if test="${not empty s.patientsPresents}">
                        <div class="border-t border-surface-100 pt-3 space-y-1.5">
                            <c:forEach var="p" items="${s.patientsPresents}">
                                <div class="flex items-center justify-between py-1">
                                    <div class="flex items-center gap-2">
                                        <div class="w-6 h-6 bg-primary-50 rounded-full flex items-center justify-center">
                                            <i data-lucide="user" class="w-3 h-3 text-primary-600"></i>
                                        </div>
                                        <span class="text-sm text-primary-800">${p.nomComplet}</span>
                                    </div>
                                    <form method="post" action="${ctx}/salles">
                                        <input type="hidden" name="action" value="liberer">
                                        <input type="hidden" name="salleId" value="${s.id}">
                                        <input type="hidden" name="patientId" value="${p.id}">
                                        <button class="text-xs text-danger-500 hover:text-danger-700 font-medium cursor-pointer transition">Liberer</button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty salles}">
        <div class="bg-white rounded-xl border border-surface-200 p-16 text-center">
            <i data-lucide="bed-double" class="w-10 h-10 text-surface-200 mx-auto mb-3"></i>
            <p class="text-surface-300 text-sm">Aucune salle creee</p>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp"/>
