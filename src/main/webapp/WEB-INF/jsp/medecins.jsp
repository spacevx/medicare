<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="flex items-center justify-between mb-5">
        <div>
            <h2 class="text-xl font-bold text-primary-900">Medecins</h2>
            <p class="text-sm text-surface-300 mt-0.5">Personnel medical et specialites</p>
        </div>
        <a href="${ctx}/medecins?action=form"
           class="inline-flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
            <i data-lucide="plus" class="w-4 h-4"></i> Nouveau Medecin
        </a>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 p-4 mb-5">
        <form method="get" action="${ctx}/medecins" class="flex flex-wrap items-end gap-4">
            <div class="flex-1 min-w-[140px]">
                <label for="fNom" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Nom</label>
                <input id="fNom" type="text" name="nom" value="${param.nom}" placeholder="Rechercher..."
                       class="w-full border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>
            <div>
                <label for="fSpec" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Specialite</label>
                <input id="fSpec" type="text" name="specialite" value="${param.specialite}" placeholder="Ex: Cardiologie"
                       class="border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 w-40 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>
            <div>
                <label for="fServ" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Service</label>
                <input id="fServ" type="text" name="service" value="${param.service}" placeholder="Ex: Urgences"
                       class="border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 w-36 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>
            <button type="submit" class="inline-flex items-center gap-1.5 bg-primary-900 text-white px-4 py-2 rounded-lg hover:bg-primary-800 transition text-sm font-medium cursor-pointer">
                <i data-lucide="search" class="w-3.5 h-3.5"></i> Filtrer
            </button>
            <a href="${ctx}/medecins" class="text-sm text-primary-600 hover:text-primary-800 font-medium cursor-pointer transition">Reinitialiser</a>
        </form>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
        <table class="min-w-full">
            <thead>
                <tr class="bg-surface-50 border-b border-surface-200">
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,0)">ID</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,1)">Nom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,2)">Prenom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider">Matricule</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,4)">Specialite</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,5)">Service</th>
                    <th class="px-5 py-3 text-right text-[11px] font-bold text-surface-300 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-surface-100">
                <c:forEach var="m" items="${medecins}">
                    <tr class="hover:bg-primary-50/40 transition">
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${m.id}</td>
                        <td class="px-5 py-3.5 text-sm font-semibold text-primary-900">${m.nom}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${m.prenom}</td>
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${m.matricule}</td>
                        <td class="px-5 py-3.5">
                            <span class="inline-flex px-2 py-0.5 rounded-full text-xs font-semibold bg-primary-50 text-primary-700 border border-primary-200">${m.specialite}</span>
                        </td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${m.service}</td>
                        <td class="px-5 py-3.5 text-right">
                            <div class="flex items-center justify-end gap-1">
                                <a href="${ctx}/medecins?action=form&id=${m.id}" title="Modifier"
                                   class="p-1.5 rounded-md hover:bg-primary-50 text-primary-600 transition cursor-pointer">
                                    <i data-lucide="pencil" class="w-4 h-4"></i>
                                </a>
                                <form method="post" action="${ctx}/medecins" class="inline" onsubmit="return confirm('Supprimer ce medecin ?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${m.id}">
                                    <button title="Supprimer" class="p-1.5 rounded-md hover:bg-danger-50 text-danger-500 transition cursor-pointer">
                                        <i data-lucide="trash-2" class="w-4 h-4"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty medecins}">
                    <tr><td colspan="7" class="px-5 py-16 text-center text-surface-300 text-sm">Aucun medecin trouve</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
