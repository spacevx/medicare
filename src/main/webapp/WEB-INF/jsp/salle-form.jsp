<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6 max-w-lg">
    <a href="${ctx}/salles" class="inline-flex items-center gap-1.5 text-primary-600 hover:text-primary-800 text-sm font-medium mb-5 transition cursor-pointer">
        <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour aux salles
    </a>

    <div class="bg-white rounded-xl border border-surface-200 p-7">
        <h2 class="text-lg font-bold text-primary-900 mb-6">Nouvelle Salle</h2>

        <form method="post" action="${ctx}/salles" class="space-y-5">
            <input type="hidden" name="action" value="add">

            <div>
                <label for="numero" class="block text-sm font-semibold text-primary-800 mb-1.5">Numero <span class="text-danger-500">*</span></label>
                <input id="numero" type="text" name="numero" required placeholder="Ex: A101"
                       class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>

            <div>
                <label for="type" class="block text-sm font-semibold text-primary-800 mb-1.5">Type <span class="text-danger-500">*</span></label>
                <select id="type" name="type" required class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                    <option value="Urgences">Urgences</option>
                    <option value="Chirurgie">Chirurgie</option>
                    <option value="Cardiologie">Cardiologie</option>
                    <option value="Pediatrie">Pediatrie</option>
                    <option value="Maternite">Maternite</option>
                    <option value="Reanimation">Reanimation</option>
                </select>
            </div>

            <div>
                <label for="capacite" class="block text-sm font-semibold text-primary-800 mb-1.5">Capacite (lits) <span class="text-danger-500">*</span></label>
                <input id="capacite" type="number" name="capacite" min="1" max="20" value="4" required
                       class="w-full border border-surface-200 rounded-lg px-3.5 py-2.5 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>

            <div class="flex gap-3 pt-3">
                <button type="submit" class="inline-flex items-center gap-2 bg-primary-600 text-white px-5 py-2.5 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
                    <i data-lucide="check" class="w-4 h-4"></i> Ajouter
                </button>
                <a href="${ctx}/salles" class="inline-flex items-center px-5 py-2.5 rounded-lg border border-surface-200 text-primary-800 hover:bg-surface-50 transition text-sm font-medium cursor-pointer">Annuler</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
