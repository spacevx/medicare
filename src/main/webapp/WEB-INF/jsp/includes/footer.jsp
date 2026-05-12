<%@ page contentType="text/html;charset=UTF-8" %>
</main>
<script>
lucide.createIcons();

function sortTable(th, colIdx) {
    const table = th.closest('table');
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    if (rows.length <= 1 && rows[0]?.querySelector('td[colspan]')) return;

    const asc = th.dataset.sort !== 'asc';
    table.querySelectorAll('th').forEach(h => { h.dataset.sort = ''; h.classList.remove('text-primary-600'); });
    th.dataset.sort = asc ? 'asc' : 'desc';
    th.classList.add('text-primary-600');

    rows.sort((a, b) => {
        const aVal = a.children[colIdx]?.textContent.trim() || '';
        const bVal = b.children[colIdx]?.textContent.trim() || '';
        const aNum = parseFloat(aVal.replace(/[^0-9.\-]/g, ''));
        const bNum = parseFloat(bVal.replace(/[^0-9.\-]/g, ''));
        if (!isNaN(aNum) && !isNaN(bNum)) return asc ? aNum - bNum : bNum - aNum;
        return asc ? aVal.localeCompare(bVal, 'fr') : bVal.localeCompare(aVal, 'fr');
    });

    rows.forEach(r => tbody.appendChild(r));
}
</script>
</body>
</html>
