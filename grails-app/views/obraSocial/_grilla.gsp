<table class="ajax">
    <thead>
    <tr>

        <g:sortableColumn property="sigla" title="${message(code: 'obraSocial.sigla.label', default: 'Sigla')}" params="${filters}" />

        <g:sortableColumn property="nombre" title="${message(code: 'obraSocial.nombre.label', default: 'Nombre')}" params="${filters}" />

        <g:sortableColumn property="codigo" title="${message(code: 'obraSocial.codigo.label', default: 'Codigo')}" params="${filters}" />

        <g:sortableColumn property="cuit" title="${message(code: 'obraSocial.cuit.label', default: 'Cuit')}" params="${filters}" />

        <g:sortableColumn property="observacion" title="${message(code: 'obraSocial.observacion.label', default: 'Observacion')}" params="${filters}" />

        <g:sortableColumn property="activa" title="${message(code: 'obraSocial.activa.label', default: 'Activa')}" params="${filters}" />

        <th></th>

        <th></th>

        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${obraSocialInstanceList}" status="i" var="obraSocialInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td>${fieldValue(bean: obraSocialInstance, field: "sigla")}</td>

            <td>${fieldValue(bean: obraSocialInstance, field: "nombre")}</td>

            <td>${fieldValue(bean: obraSocialInstance, field: "codigo")}</td>

            <td>${fieldValue(bean: obraSocialInstance, field: "cuit")}</td>

            <td>${fieldValue(bean: obraSocialInstance, field: "observacion")}</td>

            <td><g:formatBoolean boolean="${obraSocialInstance.activa}" /></td>

            <td><g:link class="linkEdit" action="edit" id="${obraSocialInstance.id}">${message(code: 'default.button.edit.label')}</g:link></td>

            <td><g:link class="linkShow" action="show" id="${obraSocialInstance.id}">${message(code: 'default.button.show.label')}</g:link></td>

            <td><g:link class="linkCuentaCorriente" action="" id="${obraSocialInstance.id}">${message(code: 'obraSocial.cuentaCorriente')}</g:link></td>

        </tr>
    </g:each>
    </tbody>
</table>
<div class="pagination">
    <g:paginate total="${obraSocialInstanceCount ?: 0}" params="${filters}" />
</div>