<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="flex items-center justify-between mb-5">
        <div>
            <h2 class="text-xl font-bold text-primary-900">Patients</h2>
            <p class="text-sm text-surface-300 mt-0.5">Gestion et suivi des patients</p>
        </div>
        <a href="${ctx}/patients?action=form"
           class="inline-flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
            <i data-lucide="plus" class="w-4 h-4"></i> Nouveau Patient
        </a>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 p-4 mb-5">
        <form method="get" action="${ctx}/patients" class="flex flex-wrap items-end gap-4">
            <div class="flex-1 min-w-[160px]">
                <label for="fNom" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Nom</label>
                <input id="fNom" type="text" name="nom" value="${param.nom}" placeholder="Rechercher..."
                       class="w-full border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 focus:border-primary-400 outline-none transition">
            </div>
            <div>
                <label for="fEtat" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Etat</label>
                <select id="fEtat" name="etat" class="border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                    <option value="">Tous</option>
                    <option value="Stable" ${param.etat == 'Stable' ? 'selected' : ''}>Stable</option>
                    <option value="Critique" ${param.etat == 'Critique' ? 'selected' : ''}>Critique</option>
                    <option value="En observation" ${param.etat == 'En observation' ? 'selected' : ''}>En observation</option>
                </select>
            </div>
            <div>
                <label for="fAdmis" class="block text-xs font-semibold text-surface-300 mb-1 uppercase tracking-wider">Admission</label>
                <select id="fAdmis" name="admis" class="border border-surface-200 rounded-lg px-3 py-2 text-sm bg-surface-50 focus:ring-2 focus:ring-primary-400 outline-none cursor-pointer">
                    <option value="">Tous</option>
                    <option value="true" ${param.admis == 'true' ? 'selected' : ''}>Admis</option>
                    <option value="false" ${param.admis == 'false' ? 'selected' : ''}>Non admis</option>
                </select>
            </div>
            <button type="submit" class="inline-flex items-center gap-1.5 bg-primary-900 text-white px-4 py-2 rounded-lg hover:bg-primary-800 transition text-sm font-medium cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400 focus:ring-offset-2">
                <i data-lucide="search" class="w-3.5 h-3.5"></i> Filtrer
            </button>
            <a href="${ctx}/patients" class="text-sm text-primary-600 hover:text-primary-800 font-medium cursor-pointer transition">Reinitialiser</a>
        </form>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
        <table class="min-w-full">
            <thead>
                <tr class="bg-surface-50 border-b border-surface-200">
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,0)">ID</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,1)">Nom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,2)">Prenom</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider">N. Secu</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,4)">Etat</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider">Statut</th>
                    <th class="px-5 py-3 text-right text-[11px] font-bold text-surface-300 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-surface-100">
                <c:forEach var="p" items="${patients}">
                    <tr class="hover:bg-primary-50/40 transition">
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${p.id}</td>
                        <td class="px-5 py-3.5 text-sm font-semibold text-primary-900">${p.nom}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${p.prenom}</td>
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${p.numeroSecu}</td>
                        <td class="px-5 py-3.5">
                            <c:choose>
                                <c:when test="${p.etatSante == 'Critique'}">
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold bg-danger-50 text-danger-700 border border-danger-100">
                                        <span class="w-1.5 h-1.5 rounded-full bg-danger-500"></span> ${p.etatSante}
                                    </span>
                                </c:when>
                                <c:when test="${p.etatSante == 'En observation'}">
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold bg-warn-50 text-warn-600 border border-warn-100">
                                        <span class="w-1.5 h-1.5 rounded-full bg-warn-500"></span> ${p.etatSante}
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold bg-accent-50 text-accent-700 border border-accent-100">
                                        <span class="w-1.5 h-1.5 rounded-full bg-accent-500"></span> ${p.etatSante}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-5 py-3.5">
                            <c:choose>
                                <c:when test="${p.estAdmis()}">
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold bg-primary-50 text-primary-700 border border-primary-200">Admis</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-sm text-surface-300">--</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-5 py-3.5 text-right">
                            <div class="flex items-center justify-end gap-1">
                                <a href="${ctx}/patients?action=dossier&id=${p.id}" title="Dossier medical"
                                   class="p-1.5 rounded-md hover:bg-accent-50 text-accent-600 transition cursor-pointer focus:outline-none focus:ring-2 focus:ring-accent-400">
                                    <i data-lucide="folder-open" class="w-4 h-4"></i>
                                </a>
                                <a href="${ctx}/patients?action=form&id=${p.id}" title="Modifier"
                                   class="p-1.5 rounded-md hover:bg-primary-50 text-primary-600 transition cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary-400">
                                    <i data-lucide="pencil" class="w-4 h-4"></i>
                                </a>
                                <c:if test="${!p.estAdmis()}">
                                    <form method="post" action="${ctx}/patients" class="inline">
                                        <input type="hidden" name="action" value="admettre">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button title="Admettre" class="p-1.5 rounded-md hover:bg-accent-50 text-accent-600 transition cursor-pointer focus:outline-none focus:ring-2 focus:ring-accent-400">
                                            <i data-lucide="log-in" class="w-4 h-4"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${p.estAdmis()}">
                                    <form method="post" action="${ctx}/patients" class="inline">
                                        <input type="hidden" name="action" value="sortie">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button title="Sortie" class="p-1.5 rounded-md hover:bg-warn-50 text-warn-600 transition cursor-pointer focus:outline-none focus:ring-2 focus:ring-warn-500">
                                            <i data-lucide="log-out" class="w-4 h-4"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <form method="post" action="${ctx}/patients" class="inline" onsubmit="return confirm('Supprimer ce patient ?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button title="Supprimer" class="p-1.5 rounded-md hover:bg-danger-50 text-danger-500 transition cursor-pointer focus:outline-none focus:ring-2 focus:ring-danger-400">
                                        <i data-lucide="trash-2" class="w-4 h-4"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty patients}">
                    <tr><td colspan="7" class="px-5 py-16 text-center text-surface-300 text-sm">Aucun patient trouve</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
