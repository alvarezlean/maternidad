<div class="fieldcontain">
Total=${total}
</div>
<table>
    <thead>
    <tr>

        <th><g:message code="movimientoStock.producto.label" default="Producto" /></th>

        <th><g:message code="movimientoStock.destino.label" default="Destino" /></th>

        <g:sortableColumn property="cantidad" title="${message(code: 'movimientoStock.cantidad.label', default: 'Cantidad')}" />

        <g:sortableColumn property="ingreso" title="${message(code: 'movimientoStock.ingreso.label', default: 'Ingreso')}" />

        <g:sortableColumn property="descripcion" title="${message(code: 'movimientoStock.descripcion.label', default: 'Descripcion')}" />

        <g:sortableColumn property="fecha" title="${message(code: 'movimientoStock.fecha.label', default: 'Fecha')}" />

    </tr>
    </thead>
    <tbody>
    <g:each in="${movimientoStockInstanceList}" status="i" var="movimientoStockInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show" id="${movimientoStockInstance.id}">${fieldValue(bean: movimientoStockInstance, field: "producto")}</g:link></td>

            <td>${fieldValue(bean: movimientoStockInstance, field: "destino")}</td>

            <td>${fieldValue(bean: movimientoStockInstance, field: "cantidad")}</td>

            <td><g:formatBoolean boolean="${movimientoStockInstance.ingreso}" /></td>

            <td>${fieldValue(bean: movimientoStockInstance, field: "descripcion")}</td>

            <td><g:formatDate date="${movimientoStockInstance.fecha}" /></td>

        </tr>
    </g:each>
    </tbody>
</table>
<div class="pagination">
    <g:paginate total="${movimientoStockInstanceCount ?: 0}" />
</div>