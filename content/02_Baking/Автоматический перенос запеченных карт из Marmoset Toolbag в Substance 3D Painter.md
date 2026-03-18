---
draft: false
description: Перекидываем карты бейка автоматически из мармы в пэйнтер.
---
Для корректного автоматического импорта запеченных карт (Mesh Maps) из Marmoset Toolbag в Substance 3D Painter необходимо синхронизировать их нейминг, так как по умолчанию программы используют разные суффиксы.

## Шаг 1: Настройка суффиксов в Marmoset Toolbag

В Marmoset Toolbag нажмите на иконку шестеренки рядом с каждой картой в настройках запекания и замените стандартные названия на те, которые понимает Substance 3D Painter. 

> [!info] Формат нейминга
> Для успешного импорта можно использовать как  **Usage**, так и **Identifier**.

| Тип карты (Mesh Map) | Суффикс (Usage) | Суффикс (Identifier) |
| :--- | :--- | :--- |
| Ambient Occlusion | `ambientOcclusionBase` | `ambient_occlusion` |
| ID | `id` | `id` |
| Curvature | `curvature` | `curvature` |
| Normal | `normalBase` | `normal_base` |
| World Space Normals | `normalWS` | `world_space_normals` |
| Position | `position` | `position` |
| Thickness | `thickness` | `thickness` |
| Height | `heightBase` | `height_base` |
| Bent Normals | `bentNormalsBase` | `bent_normals_base` |
| Opacity | `opacityBase` | `opacity_base` |

![Настройка нейминга в Marmoset Toolbag](image.webp)

## Шаг 2: Обход принудительного префикса при экспорте

При экспорте Marmoset Toolbag принудительно добавляет собственное имя к файлу (например, получается `Bake_Mesh01_normal_base` вместо чистого `Mesh01_normal_base`). Из-за лишнего префикса Substance 3D Painter не распознает эти карты автоматически. Отключить добавление префикса внутри Marmoset нельзя.

Решение:
1. В поле имени файла (префикса) при запекании в Marmoset Toolbag поставьте только нижнее подчеркивание `_`.
2. Запеките карты.

## Шаг 3: Пакетная очистка названий (Windows)

Теперь нужно удалить ведущее нижнее подчеркивание у всех файлов, чтобы получить "чистые" названия. Быстрее всего это сделать через терминал.

1. Откройте папку с запеченными картами.
2. Кликните правой кнопкой мыши по пустому месту внутри папки и выберите **Открыть в терминале** (в Windows 11).

![Терминал Windows](image-1.webp)

3. Введите следующий код и нажмите Enter:

```powershell
Get-ChildItem -Filter "_*" | Rename-Item -NewName {$_.Name -replace "^_", ""}
```

Скрипт автоматически удалит нижнее подчеркивание в начале имени у всех файлов в папке.

## Шаг 4: Импорт в Substance 3D Painter

1. В Substance 3D Painter при создании нового проекта откройте раздел **Import baked maps**.
2. Нажмите **Add** и выберите очищенные карты. 
3. Программа автоматически подцепит к каждому текстурному сету соответствующий набор мешмап.

Источники:
1. https://experienceleague.adobe.com/en/docs/substance-3d-painter/using/content/creating-custom-effects/mesh-map#
2. 