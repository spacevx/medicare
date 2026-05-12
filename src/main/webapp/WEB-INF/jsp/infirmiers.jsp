<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="flex items-center justify-between mb-5">
        <div>
            <h2 class="text-xl font-bold text-primary-900">Infirmiers</h2>
            <p class="text-sm text-surface-300 mt-0.5">Personnel infirmier et affectations</p>
        </div>
        <a href="${ctx}/infirmiers?action=form"
           class="inline-flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer">
            <i data-lucide="plus" class="w-4 h-4"></i> Nouveau
        </a>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 p-4 mb-5">
        <form method="get" action="${ctx}/infirmiers" class="flex flex-wrap items-end gap-4">
            <div class="flex-1 min-w-[140px]">
                <label for="fNom" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Nom</label>
                <input id="fNom" type="text" name="nom" value="${param.nom}" placeholder="Rechercher..."
                       class="w-full border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>
            <div>
                <label for="fServ" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Service</label>
                <input id="fServ" type="text" name="service" value="${param.service}" placeholder="Ex: Urgences"
                       class="border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 w-40 focus:ring-2 focus:ring-primary-400 outline-none transition">
            </div>
            <button type="submit" class="inline-flex items-center gap-1.5 bg-primary-900 text-white px-4 py-2 rounded-lg hover:bg-primary-800 transition text-sm font-medium cursor-pointer">
                <i data-lucide="search" class="w-3.5 h-3.5"></i> Filtrer
            </button>
            <a href="${ctx}/infirmiers" class="text-sm text-primary-600 hover:text-primary-800 font-medium cursor-pointer transition">Reinitialiser</a>
        </form>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
        <table class="min-w-full sortable">
            <thead>
                <tr class="bg-surface-50 border-b border-surface-200">
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer" onclick="sortTable(this,0)">ID</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer" onclick="sortTable(this,1)">Nom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer" onclick="sortTable(this,2)">Prenom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider">Matricule</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer" onclick="sortTable(this,4)">Service</th>
                    <th class="px-5 py-3 text-right text-[11px] font-bold text-surface-300 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-surface-100">
                <c:forEach var="inf" items="${infirmiers}">
                    <tr class="hover:bg-primary-50/40 transition">
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${inf.id}</td>
                        <td class="px-5 py-3.5 text-sm font-semibold text-primary-900">${inf.nom}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${inf.prenom}</td>
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${inf.matricule}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${inf.service}</td>
                        <td class="px-5 py-3.5 text-right">
                            <div class="flex items-center justify-end gap-1">
                                <a href="${ctx}/infirmiers?action=form&id=${inf.id}" title="Modifier"
                                   class="p-1.5 rounded-md hover:bg-primary-50 text-primary-600 transition cursor-pointer">
                                    <i data-lucide="pencil" class="w-4 h-4"></i>
                                </a>
                                <form method="post" action="${ctx}/infirmiers" class="inline" onsubmit="return confirm('Supprimer ?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${inf.id}">
                                    <button title="Supprimer" class="p-1.5 rounded-md hover:bg-danger-50 text-danger-500 transition cursor-pointer">
                                        <i data-lucide="trash-2" class="w-4 h-4"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty infirmiers}">
                    <tr><td colspan="6" class="px-5 py-16 text-center text-surface-300 text-sm">Aucun infirmier trouve</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
