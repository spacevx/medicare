<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="includes/header.jsp"/>

<div class="px-8 py-6">
    <div class="flex items-center justify-between mb-5">
        <div>
            <h2 class="text-xl font-bold text-primary-900">Soins</h2>
            <p class="text-sm text-surface-300 mt-0.5">Consultations et actes chirurgicaux</p>
        </div>
        <div class="flex gap-2">
            <a href="${ctx}/soins?action=form&type=consultation"
               class="inline-flex items-center gap-2 bg-accent-600 text-white px-4 py-2 rounded-lg hover:bg-accent-700 transition text-sm font-semibold cursor-pointer">
                <i data-lucide="plus" class="w-4 h-4"></i> Consultation
            </a>
            <a href="${ctx}/soins?action=form&type=chirurgical"
               class="inline-flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition text-sm font-semibold cursor-pointer">
                <i data-lucide="plus" class="w-4 h-4"></i> Acte Chirurgical
            </a>
        </div>
    </div>

    <div class="bg-white rounded-xl border border-surface-200 overflow-hidden">
        <table class="min-w-full">
            <thead>
                <tr class="bg-surface-50 border-b border-surface-200">
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,0)">ID</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,1)">Type</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,2)">Date</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider">Description</th>
                    <th class="px-5 py-3 text-left text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,4)">Medecin</th>
                    <th class="px-5 py-3 text-right text-[11px] font-bold text-surface-300 uppercase tracking-wider cursor-pointer hover:text-primary-600 transition" onclick="sortTable(this,5)">Cout</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-surface-100">
                <c:forEach var="s" items="${soins}">
                    <tr class="hover:bg-primary-50/40 transition">
                        <td class="px-5 py-3.5 text-sm text-surface-300 tabular-nums">${s.id}</td>
                        <td class="px-5 py-3.5">
                            <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-semibold
                                ${s.type == 'Consultation' ? 'bg-accent-50 text-accent-700 border border-accent-100' : 'bg-warn-50 text-warn-600 border border-warn-100'}">
                                <i data-lucide="${s.type == 'Consultation' ? 'stethoscope' : 'syringe'}" class="w-3 h-3"></i>
                                ${s.type}
                            </span>
                        </td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${s.date}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${s.description}</td>
                        <td class="px-5 py-3.5 text-sm text-primary-800">${s.medecin.nomComplet}</td>
                        <td class="px-5 py-3.5 text-sm font-semibold text-primary-900 text-right tabular-nums">${s.cout} EUR</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty soins}">
                    <tr><td colspan="6" class="px-5 py-16 text-center text-surface-300 text-sm">Aucun soin enregistre</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
