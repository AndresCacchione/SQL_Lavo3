use CATALOGO_DB

select a.Id, a.Codigo, a.Nombre, a.Descripcion ArtDescripcion, m.Descripcion MarDescripcion, c.Descripcion CatDescripcion, a.ImagenUrl, a.Precio
from ARTICULOS as a, MARCAS as m, CATEGORIAS as c
where m.Id = a.IdMarca and c.Id=a.IdCategoria

select * from CATEGORIAS
select * from MARCAS