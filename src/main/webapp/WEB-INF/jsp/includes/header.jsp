<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caduceus</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@300;400;500;600;700&family=Noto+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Figtree', 'Noto Sans', 'system-ui', 'sans-serif'] },
                    colors: {
                        primary:    { 50:'#ecfeff', 100:'#cffafe', 200:'#a5f3fc', 300:'#67e8f9', 400:'#22d3ee', 500:'#06b6d4', 600:'#0891b2', 700:'#0e7490', 800:'#155e75', 900:'#164e63' },
                        accent:     { 50:'#ecfdf5', 100:'#d1fae5', 400:'#34d399', 500:'#10b981', 600:'#059669', 700:'#047857' },
                        surface:    { 50:'#f8fafb', 100:'#f1f5f9', 200:'#e2e8f0', 300:'#cbd5e1' },
                        danger:     { 50:'#fef2f2', 100:'#fee2e2', 500:'#ef4444', 600:'#dc2626', 700:'#b91c1c' },
                        warn:       { 50:'#fffbeb', 100:'#fef3c7', 500:'#f59e0b', 600:'#d97706' }
                    }
                }
            }
        }
    </script>
    <style>
        * { font-family: 'Figtree', 'Noto Sans', system-ui, sans-serif; }
        .nav-link { transition: all 150ms ease-out; }
        .nav-link:hover { background: rgba(255,255,255,0.08); }
        .nav-link.active { background: rgba(255,255,255,0.12); border-right: 3px solid #22d3ee; }
    </style>
</head>
<body class="bg-surface-50 text-primary-900 min-h-screen antialiased">

<aside class="fixed left-0 top-0 h-full w-60 bg-primary-900 flex flex-col z-50 shadow-xl">
    <div class="px-5 py-5 border-b border-white/10">
        <div class="flex items-center gap-2.5">
            <div class="w-8 h-8 bg-primary-400 rounded-lg flex items-center justify-center">
                <i data-lucide="heart-pulse" class="w-5 h-5 text-primary-900"></i>
            </div>
            <div>
                <h1 class="text-[17px] font-bold text-white tracking-tight leading-tight">Caduceus</h1>
                <p class="text-[11px] text-primary-300 font-medium">Gestion Hospitaliere</p>
            </div>
        </div>
    </div>

    <nav class="flex-1 py-4 px-3 space-y-0.5">
        <a href="${ctx}/patients"
           class="nav-link ${activePage == 'patients' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="users" class="w-[18px] h-[18px]"></i> Patients
        </a>
        <a href="${ctx}/medecins"
           class="nav-link ${activePage == 'medecins' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="stethoscope" class="w-[18px] h-[18px]"></i> Medecins
        </a>
        <a href="${ctx}/infirmiers"
           class="nav-link ${activePage == 'infirmiers' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="shield-plus" class="w-[18px] h-[18px]"></i> Infirmiers
        </a>
        <a href="${ctx}/soins"
           class="nav-link ${activePage == 'soins' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="clipboard-plus" class="w-[18px] h-[18px]"></i> Soins
        </a>
        <a href="${ctx}/urgences"
           class="nav-link ${activePage == 'urgences' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="siren" class="w-[18px] h-[18px]"></i> Urgences
        </a>
        <a href="${ctx}/salles"
           class="nav-link ${activePage == 'salles' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="bed-double" class="w-[18px] h-[18px]"></i> Salles
        </a>
        <a href="${ctx}/statistiques"
           class="nav-link ${activePage == 'statistiques' ? 'active' : ''} flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-primary-200 hover:text-white">
            <i data-lucide="bar-chart-3" class="w-[18px] h-[18px]"></i> Statistiques
        </a>
    </nav>

    <div class="px-5 py-3 border-t border-white/10">
        <p class="text-[11px] text-primary-400 font-medium">Caduceus v1.0</p>
    </div>
</aside>

<main class="ml-60 min-h-screen">
    <c:if test="${not empty sessionScope.error}">
        <div class="mx-8 mt-6 flex items-center gap-3 bg-danger-50 border border-danger-100 text-danger-700 px-4 py-3 rounded-lg text-sm">
            <i data-lucide="alert-circle" class="w-4 h-4 shrink-0"></i>
            ${sessionScope.error}
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>
