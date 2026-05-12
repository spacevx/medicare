<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6 max-w-2xl">
    <a href="${ctx}/soins" class="inline-flex items-center gap-1.5 text-primary-600 hover:text-primary-800 text-sm font-medium mb-5 transition cursor-pointer">
        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour aux soins
    </a>

    <div class="bg-white rounded-xl border border-surface-200 p-7">
        <h2 class="text-lg font-bold text-primary-900 mb-6">
            ${type == 'consultation' ? 'Nouvelle Consultation' : 'Nouvel Acte Chirurgical'}
        </h2>

        <c:if test="${empty patients || empty medecins}">
            <div class="flex items-center gap-2 text-danger-600 text-sm">
                <i data-lucide="alert-circle" class="w-4 h-4"></i>
                Il faut au moins un patient et un medecin.
            </div>
        </c:if>

        <c:if test="${not empty patients && not empty medecins}">
            <form method="post" action="${ctx}/soins" class="space-y-5">
                <input type="hidden" name="type" value="${type}">

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="patientId" class="block text-sm font-semibold text-primary-800 mb-1.5">Patient <span class="text-danger-500">*</span></label>
                        <select id="patientId" name="patientId" required class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                            <c:forEach var="p" items="${patients}"><option value="${p.id}">${p.nomComplet}</option></c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="medecinId" class="block text-sm font-semibold text-primary-800 mb-1.5">Medecin <span class="text-danger-500">*</span></label>
                        <select id="medecinId" name="medecinId" required class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                            <c:forEach var="m" items="${medecins}"><option value="${m.id}">Dr. ${m.nomComplet}</option></c:forEach>
                        </select>
                    </div>
                </div>

                <div>
                    <label for="description" class="block text-sm font-semibold text-primary-800 mb-1.5">Description</label>
                    <input id="description" type="text" name="description" class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                </div>

                <div>
                    <label for="cout" class="block text-sm font-semibold text-primary-800 mb-1.5">Cout (EUR) <span class="text-danger-500">*</span></label>
                    <input id="cout" type="number" name="cout" step="0.01" value="${type == 'consultation' ? '50' : '500'}" required
                           class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                </div>

                <c:if test="${type == 'consultation'}">
                    <div>
                        <label for="diagnostic" class="block text-sm font-semibold text-primary-800 mb-1.5">Diagnostic</label>
                        <input id="diagnostic" type="text" name="diagnostic" class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                    </div>
                </c:if>

                <c:if test="${type == 'chirurgical'}">
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="niveauUrgence" class="block text-sm font-semibold text-primary-800 mb-1.5">Niveau urgence (1-5) <span class="text-danger-500">*</span></label>
                            <input id="niveauUrgence" type="number" name="niveauUrgence" min="1" max="5" value="3" required
                                   class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                        </div>
                        <div>
                            <label for="salle" class="block text-sm font-semibold text-primary-800 mb-1.5">Salle</label>
                            <input id="salle" type="text" name="salle" class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
                        </div>
                    </div>
                </c:if>

                <div class="flex gap-3 pt-3">
                    <button type="submit" class="inline-flex items-center gap-2 bg-primary-600 text-white px-5 py-2.5 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
                        <i data-lucide="check" class="w-4 h-4"></i> Enregistrer
                    </button>
                    <a href="${ctx}/soins" class="inline-flex items-center px-5 py-2.5 rounded-lg border border-surface-200 text-primary-800 hover:bg-surface-50 transition text-sm font-medium cursor-pointer">Annuler</a>
                </div>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
