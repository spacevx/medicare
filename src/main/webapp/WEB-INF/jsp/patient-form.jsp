<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6 max-w-2xl">
    <a href="${ctx}/patients" class="inline-flex items-center gap-1.5 text-primary-600 hover:text-primary-800 text-sm font-medium mb-5 transition cursor-pointer">
        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour aux patients
    </a>

    <div class="bg-white rounded-xl border border-surface-200 p-7">
        <h2 class="text-lg font-bold text-primary-900 mb-6">
            ${patient != null ? 'Modifier le patient' : 'Nouveau patient'}
        </h2>

        <form method="post" action="${ctx}/patients" class="space-y-5">
            <input type="hidden" name="action" value="${patient != null ? 'update' : 'add'}">
            <c:if test="${patient != null}">
                <input type="hidden" name="id" value="${patient.id}">
            </c:if>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label for="nom" class="block text-sm font-semibold text-primary-800 mb-1.5">Nom <span class="text-danger-500">*</span></label>
                    <input id="nom" type="text" name="nom" value="${patient.nom}" required
                           class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 focus:border-primary-400 outline-none transition">
                </div>
                <div>
                    <label for="prenom" class="block text-sm font-semibold text-primary-800 mb-1.5">Prenom <span class="text-danger-500">*</span></label>
                    <input id="prenom" type="text" name="prenom" value="${patient.prenom}" required
                           class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 focus:border-primary-400 outline-none transition">
                </div>
            </div>

            <c:if test="${patient == null}">
                <div>
                    <label for="dateNaissance" class="block text-sm font-semibold text-primary-800 mb-1.5">Date de naissance <span class="text-danger-500">*</span></label>
                    <input id="dateNaissance" type="date" name="dateNaissance" required
                           class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 focus:border-primary-400 outline-none transition">
                </div>
            </c:if>

            <div>
                <label for="numeroSecu" class="block text-sm font-semibold text-primary-800 mb-1.5">N. Securite Sociale <span class="text-danger-500">*</span></label>
                <input id="numeroSecu" type="text" name="numeroSecu" value="${patient.numeroSecu}" required
                       class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 focus:border-primary-400 outline-none transition">
            </div>

            <c:if test="${patient != null}">
                <div>
                    <label for="etatSante" class="block text-sm font-semibold text-primary-800 mb-1.5">Etat de sante</label>
                    <select id="etatSante" name="etatSante" class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                        <option value="Stable" ${patient.etatSante == 'Stable' ? 'selected' : ''}>Stable</option>
                        <option value="Critique" ${patient.etatSante == 'Critique' ? 'selected' : ''}>Critique</option>
                        <option value="En observation" ${patient.etatSante == 'En observation' ? 'selected' : ''}>En observation</option>
                        <option value="En rémission" ${patient.etatSante == 'En rémission' ? 'selected' : ''}>En remission</option>
                    </select>
                </div>
            </c:if>

            <div class="flex gap-3 pt-3">
                <button type="submit"
                        class="inline-flex items-center gap-2 bg-primary-600 text-white px-5 py-2.5 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
                    <i data-lucide="check" class="w-4 h-4"></i> ${patient != null ? 'Enregistrer' : 'Ajouter'}
                </button>
                <a href="${ctx}/patients"
                   class="inline-flex items-center px-5 py-2.5 rounded-lg border border-surface-200 text-primary-800 hover:bg-surface-50 transition text-sm font-medium cursor-pointer">
                    Annuler
                </a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
