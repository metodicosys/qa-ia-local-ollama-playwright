$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression

$path = Join-Path (Get-Location) 'Casos_Prueba_EAEmployee.xlsx'
$cases = New-Object 'System.Collections.Generic.List[object]'
$cases.Add([pscustomobject]@{
    Id = 'CP-01'; Title = 'Inicio de sesión válido'; Preconditions = 'Credenciales de administrador autorizadas.'
    Steps = "1. Abrir la página de inicio de sesión.`n2. Ingresar el usuario admin y la contraseña proporcionada.`n3. Pulsar Sign In."
    Expected = 'Se abre la página principal con la sesión iniciada como admin y las funciones de administración disponibles.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-02'; Title = 'Inicio de sesión inválido'; Preconditions = 'Sesión cerrada.'
    Steps = "1. Abrir el inicio de sesión.`n2. Probar una contraseña incorrecta y enviar.`n3. Probar enviar el formulario vacío."
    Expected = 'Se rechaza el acceso, se muestra un error claro y no se habilitan funciones de administrador.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-03'; Title = 'Lista de empleados'; Preconditions = 'Sesión de administrador iniciada.'
    Steps = "1. Abrir Employees.`n2. Revisar encabezados, registros visibles, total y paginación."
    Expected = 'La tabla muestra nombre, edad, salario, duración, grado y correo; el total y los registros coinciden con los datos disponibles.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-04'; Title = 'Búsqueda por nombre y correo'; Preconditions = 'Sesión iniciada; lista de empleados abierta.'
    Steps = "1. Buscar por un nombre conocido.`n2. Repetir con un correo conocido.`n3. Buscar un término sin coincidencias."
    Expected = 'Los resultados corresponden al criterio de búsqueda. Si no hay coincidencias, se informa sin error ni registros incorrectos.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-05'; Title = 'Filtro por grado'; Preconditions = 'Sesión iniciada; lista de empleados abierta.'
    Steps = "1. Seleccionar Junior, Middle, Senior y C-Level, uno a la vez.`n2. Pulsar Search en cada selección.`n3. Seleccionar All Grades."
    Expected = 'Cada filtro presenta solo empleados del grado elegido; All Grades restaura la lista sin filtrar.'; Priority = 'Media'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-06'; Title = 'Paginación'; Preconditions = 'Sesión iniciada; lista de empleados abierta.'
    Steps = "1. Ir a la página siguiente y a una página intermedia.`n2. Probar Prev y Next.`n3. Abrir la última página."
    Expected = 'La navegación muestra los registros correspondientes y los controles Prev/Next funcionan en los límites de la paginación.'; Priority = 'Media'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-07'; Title = 'Detalles y contribuciones'; Preconditions = 'Sesión iniciada; existe un empleado que se puede consultar.'
    Steps = "1. Abrir Details de un empleado.`n2. Comparar sus datos con la fila de la lista.`n3. Revisar los importes de PF/contribuciones."
    Expected = 'Los datos pertenecen al empleado seleccionado y los importes son coherentes con el salario y la duración mostrados.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-08'; Title = 'Crear empleado válido'; Preconditions = 'Sesión de administrador iniciada; usar datos ficticios y correo de prueba.'
    Steps = "1. Abrir New Employee.`n2. Completar nombre, edad, salario mensual, duración, grado y correo válidos.`n3. Pulsar Create Employee.`n4. Buscar el registro creado."
    Expected = 'Se crea un único registro; aparece en la lista y sus detalles coinciden con los valores ingresados.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-09'; Title = 'Validación al crear empleado'; Preconditions = 'Sesión de administrador iniciada; no enviar datos personales reales.'
    Steps = "1. Abrir New Employee.`n2. Enviar el formulario vacío.`n3. Probar valores inválidos: texto en campos numéricos y formato de correo incorrecto."
    Expected = 'Se indican los campos inválidos, no se crea el registro y se conservan los datos válidos ingresados cuando corresponda.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-10'; Title = 'Editar empleado de prueba'; Preconditions = 'Sesión de administrador iniciada; usar un empleado creado para pruebas.'
    Steps = "1. Abrir Edit del empleado de prueba.`n2. Cambiar uno o más campos y guardar.`n3. Volver a consultar la lista y los detalles."
    Expected = 'Los cambios quedan guardados y se reflejan en la lista y los detalles; ningún otro empleado cambia.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-11'; Title = 'Cancelar y confirmar eliminación'; Preconditions = 'Sesión de administrador iniciada; usar solo un empleado de prueba.'
    Steps = "1. Abrir Delete del empleado de prueba y cancelar.`n2. Confirmar que sigue en la lista.`n3. Repetir y confirmar la eliminación."
    Expected = 'Al cancelar, el registro permanece. Al confirmar, deja de aparecer y el total se actualiza.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-12'; Title = 'Dashboard y métricas'; Preconditions = 'Sesión de administrador iniciada; disponer de datos conocidos para comparar.'
    Steps = "1. Abrir Dashboard.`n2. Revisar total, promedios, distribución por edad/grado y listados destacados.`n3. Pulsar Refresh.`n4. Comparar con cálculos independientes de los registros disponibles."
    Expected = 'Las métricas y listados son coherentes con los datos. Refresh recarga los valores. Registrar cualquier discrepancia con evidencia.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-13'; Title = 'Cerrar sesión'; Preconditions = 'Sesión de administrador iniciada.'
    Steps = "1. Pulsar Logout.`n2. Intentar abrir una página de administración desde la URL o el historial."
    Expected = 'La sesión termina. Las páginas protegidas requieren iniciar sesión o deniegan el acceso.'; Priority = 'Alta'
})
$cases.Add([pscustomobject]@{
    Id = 'CP-14'; Title = 'Permisos de usuario estándar'; Preconditions = 'Disponer de una cuenta estándar autorizada, distinta de admin.'
    Steps = "1. Iniciar sesión con la cuenta estándar.`n2. Revisar las opciones disponibles.`n3. Intentar abrir las páginas de creación, edición y eliminación."
    Expected = 'Las acciones exclusivas de administrador no están disponibles ni se permiten al acceder directamente a esas páginas.'; Priority = 'Alta'
})

$headers = @('ID', 'Caso de prueba', 'Precondiciones', 'Pasos', 'Resultado esperado', 'Prioridad', 'Estado', 'Resultado real / notas', 'Probador', 'Fecha', 'Evidencia / enlace')
$instructions = @(
    @('Elemento', 'Instrucción'),
    @('Objetivo', 'Casos manuales para EA Employee App: inicio de sesión, empleados, búsqueda, permisos y dashboard.'),
    @('Ejecución', 'Completar Estado, Resultado real / notas, Probador, Fecha y Evidencia / enlace durante la ejecución.'),
    @('Estados', 'La columna Estado incluye una lista: Pendiente, Aprobado, Fallido o No aplica.'),
    @('Datos de prueba', 'Usar datos ficticios. Para crear, editar o eliminar, usar únicamente registros de prueba y limpiar esos registros al finalizar.'),
    @('Credenciales', 'Usar las credenciales de administrador proporcionadas por el solicitante. No se guardan contraseñas en este archivo.'),
    @('Observación inicial', 'En la revisión visual, el dashboard mostró cifras salariales extraordinariamente altas. Validar los cálculos con datos controlados y registrar discrepancias; no tomar los valores actuales como esperado.'),
    @('Alcance', 'Los casos se redactaron a partir de las pantallas visibles. No se ejecutaron altas, ediciones ni eliminaciones durante su preparación.')
)

$xlsPath = Join-Path (Get-Location) 'Casos_Prueba_EAEmployee.xls'
if (Test-Path $xlsPath) {
    throw "Refusing to overwrite existing file: $xlsPath"
}

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false
$workbook = $null
try {
    $workbook = $excel.Workbooks.Add()
    $sheet = $workbook.Worksheets.Item(1)
    $sheet.Name = 'Casos'
    $instructionsSheet = $workbook.Worksheets.Add()
    $instructionsSheet.Name = 'Instrucciones'

    $headerData = New-Object 'object[,]' 1, $headers.Count
    for ($column = 0; $column -lt $headers.Count; $column++) {
        $headerData[0, $column] = $headers[$column]
    }
    $sheet.Range('A1:K1').Value2 = $headerData

    $caseData = New-Object 'object[,]' $cases.Count, $headers.Count
    for ($row = 0; $row -lt $cases.Count; $row++) {
        $case = $cases[$row]
        $values = @($case.Id, $case.Title, $case.Preconditions, $case.Steps, $case.Expected, $case.Priority, 'Pendiente', '', '', '', '')
        for ($column = 0; $column -lt $headers.Count; $column++) {
            $caseData[$row, $column] = $values[$column]
        }
    }
    $lastCaseRow = $cases.Count + 1
    $sheet.Range(('A2:K{0}' -f $lastCaseRow)).Value2 = $caseData

    $sheet.Range('A1:K1').Interior.Color = 0x5D3617
    $sheet.Range('A1:K1').Font.Color = 0xFFFFFF
    $sheet.Range('A1:K1').Font.Bold = $true
    $sheet.Range('A1:K1').WrapText = $true
    $sheet.Range(('A1:K{0}' -f $lastCaseRow)).VerticalAlignment = -4160
    $sheet.Range(('A2:K{0}' -f $lastCaseRow)).WrapText = $true
    $sheet.Rows.Item(1).RowHeight = 32
    for ($row = 2; $row -le $lastCaseRow; $row++) {
        $sheet.Rows.Item($row).RowHeight = 72
    }
    $widths = @(10, 28, 38, 58, 58, 12, 18, 42, 18, 16, 30)
    for ($column = 1; $column -le $widths.Count; $column++) {
        $sheet.Columns.Item($column).ColumnWidth = $widths[$column - 1]
    }
    $sheet.Range(('A1:K{0}' -f $lastCaseRow)).Borders.LineStyle = 1
    $sheet.Range(('A1:K{0}' -f $lastCaseRow)).AutoFilter()
    $statusRange = $sheet.Range(('G2:G{0}' -f $lastCaseRow))
    $statusRange.Validation.Add(3, 1, 1, 'Pendiente,Aprobado,Fallido,No aplica')

    $instructionData = New-Object 'object[,]' $instructions.Count, 2
    for ($row = 0; $row -lt $instructions.Count; $row++) {
        for ($column = 0; $column -lt 2; $column++) {
            $instructionData[$row, $column] = $instructions[$row][$column]
        }
    }
    $lastInstructionRow = $instructions.Count
    $instructionsSheet.Range(('A1:B{0}' -f $lastInstructionRow)).Value2 = $instructionData
    $instructionsSheet.Range('A1:B1').Interior.Color = 0x5D3617
    $instructionsSheet.Range('A1:B1').Font.Color = 0xFFFFFF
    $instructionsSheet.Range('A1:B1').Font.Bold = $true
    $instructionsSheet.Range(('A1:B{0}' -f $lastInstructionRow)).WrapText = $true
    $instructionsSheet.Range(('A1:B{0}' -f $lastInstructionRow)).VerticalAlignment = -4160
    $instructionsSheet.Range(('A1:B{0}' -f $lastInstructionRow)).Borders.LineStyle = 1
    $instructionsSheet.Columns.Item(1).ColumnWidth = 24
    $instructionsSheet.Columns.Item(2).ColumnWidth = 110
    $instructionsSheet.Range(('A1:B{0}' -f $lastInstructionRow)).AutoFilter()
    $instructionsSheet.Rows.Item(1).RowHeight = 32
    for ($row = 2; $row -le $lastInstructionRow; $row++) {
        $instructionsSheet.Rows.Item($row).RowHeight = 44
    }

    $sheet.Activate()
    $sheet.Range('A2').Select()
    $excel.ActiveWindow.FreezePanes = $true
    $workbook.SaveAs($xlsPath, 56)
    $workbook.Close($false)
    $workbook = $null
}
finally {
    if ($workbook) {
        $workbook.Close($false)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($workbook)
    }
    $excel.Quit()
    [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel)
}

if (Test-Path $path) {
    Remove-Item -LiteralPath $path
}
Get-Item $xlsPath | Select-Object FullName, Length
exit 0

function XmlEscape([string]$text) {
    return [System.Security.SecurityElement]::Escape($text)
}

function CellRef([int]$column, [int]$row) {
    $letters = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K')
    return ($letters[$column - 1] + $row)
}

function InlineCell([int]$column, [int]$row, [string]$text, [int]$style) {
    $reference = CellRef $column $row
    $safeText = XmlEscape $text
    return ('<c r="{0}" s="{1}" t="inlineStr"><is><t xml:space="preserve">{2}</t></is></c>' -f $reference, $style, $safeText)
}

function AddZipText($zip, [string]$name, [string]$text) {
    $entry = $zip.CreateEntry($name)
    $stream = $entry.Open()
    $writer = New-Object System.IO.StreamWriter($stream, (New-Object System.Text.UTF8Encoding($false)))
    $writer.Write($text)
    $writer.Dispose()
}

$sheet1 = New-Object System.Text.StringBuilder
[void]$sheet1.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetViews><sheetView workbookViewId="0"><pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/></sheetView></sheetViews><sheetFormatPr defaultRowHeight="30"/><cols>')
$widths = @(10, 28, 38, 58, 58, 12, 18, 42, 18, 16, 30)
for ($i = 0; $i -lt $widths.Count; $i++) {
    $column = $i + 1
    [void]$sheet1.Append(('<col min="{0}" max="{0}" width="{1}" customWidth="1"/>' -f $column, $widths[$i]))
}
[void]$sheet1.Append('<sheetData><row r="1" ht="34" customHeight="1">')
for ($i = 0; $i -lt $headers.Count; $i++) {
    [void]$sheet1.Append((InlineCell ($i + 1) 1 $headers[$i] 1))
}
[void]$sheet1.Append('</row>')

for ($r = 0; $r -lt $cases.Count; $r++) {
    $row = $r + 2
    [void]$sheet1.Append(('<row r="{0}" ht="92" customHeight="1">' -f $row))
    $case = $cases[$r]
    $values = @($case.Id, $case.Title, $case.Preconditions, $case.Steps, $case.Expected, $case.Priority)
    for ($c = 0; $c -lt $values.Count; $c++) {
        $style = if ($c -eq 0) { 3 } else { 2 }
        [void]$sheet1.Append((InlineCell ($c + 1) $row $values[$c] $style))
    }
    [void]$sheet1.Append((InlineCell 7 $row 'Pendiente' 2))
    for ($c = 8; $c -le 11; $c++) {
        [void]$sheet1.Append((InlineCell $c $row '' 2))
    }
    [void]$sheet1.Append('</row>')
}

$lastRow = $cases.Count + 1
[void]$sheet1.Append(('</sheetData><autoFilter ref="A1:K{0}"/><dataValidations count="1"><dataValidation type="list" allowBlank="1" showErrorMessage="1" sqref="G2:G{0}"><formula1>"Pendiente,Aprobado,Fallido,No aplica"</formula1></dataValidation></dataValidations><pageMargins left="0.25" right="0.25" top="0.5" bottom="0.5" header="0.2" footer="0.2"/></worksheet>' -f $lastRow))

$sheet2 = New-Object System.Text.StringBuilder
[void]$sheet2.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetViews><sheetView workbookViewId="0"><pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/></sheetView></sheetViews><sheetFormatPr defaultRowHeight="36"/><cols><col min="1" max="1" width="24" customWidth="1"/><col min="2" max="2" width="110" customWidth="1"/></cols><sheetData>')
for ($r = 0; $r -lt $instructions.Count; $r++) {
    $row = $r + 1
    $height = if ($r -eq 0) { 32 } else { 54 }
    [void]$sheet2.Append(('<row r="{0}" ht="{1}" customHeight="1">' -f $row, $height))
    for ($c = 0; $c -lt 2; $c++) {
        $style = if ($r -eq 0) { 1 } else { 2 }
        [void]$sheet2.Append((InlineCell ($c + 1) $row $instructions[$r][$c] $style))
    }
    [void]$sheet2.Append('</row>')
}
[void]$sheet2.Append('</sheetData><autoFilter ref="A1:B8"/><pageMargins left="0.25" right="0.25" top="0.5" bottom="0.5" header="0.2" footer="0.2"/></worksheet>')

$styles = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <fonts count="2"><font><sz val="11"/><name val="Calibri"/></font><font><b/><color rgb="FFFFFFFF"/><sz val="11"/><name val="Calibri"/></font></fonts>
  <fills count="3"><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="gray125"/></fill><fill><patternFill patternType="solid"><fgColor rgb="FF17365D"/><bgColor indexed="64"/></patternFill></fill></fills>
  <borders count="2"><border><left/><right/><top/><bottom/><diagonal/></border><border><left style="thin"><color rgb="FFD9E2F3"/></left><right style="thin"><color rgb="FFD9E2F3"/></right><top style="thin"><color rgb="FFD9E2F3"/></top><bottom style="thin"><color rgb="FFD9E2F3"/></bottom><diagonal/></border></borders>
  <cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
  <cellXfs count="4"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/><xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment vertical="center" wrapText="1"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="1" xfId="0" applyBorder="1" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf><xf numFmtId="0" fontId="1" fillId="0" borderId="1" xfId="0" applyFont="1" applyBorder="1" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf></cellXfs>
  <cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>
</styleSheet>
'@
$types = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
  <Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
  <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
</Types>
'@
$rootRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>
'@
$workbook = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><bookViews><workbookView/></bookViews><sheets><sheet name="Casos" sheetId="1" r:id="rId1"/><sheet name="Instrucciones" sheetId="2" r:id="rId2"/></sheets><calcPr calcId="191029"/></workbook>
'@
$wbRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>
'@

if (Test-Path $path) {
    throw "Refusing to overwrite existing file: $path"
}
$fileStream = [System.IO.File]::Open($path, [System.IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fileStream, [System.IO.Compression.ZipArchiveMode]::Create, $false)
try {
    AddZipText $zip '[Content_Types].xml' $types
    AddZipText $zip '_rels/.rels' $rootRels
    AddZipText $zip 'xl/workbook.xml' $workbook
    AddZipText $zip 'xl/_rels/workbook.xml.rels' $wbRels
    AddZipText $zip 'xl/styles.xml' $styles
    AddZipText $zip 'xl/worksheets/sheet1.xml' $sheet1.ToString()
    AddZipText $zip 'xl/worksheets/sheet2.xml' $sheet2.ToString()
}
finally {
    $zip.Dispose()
}

Get-Item $path | Select-Object FullName, Length
