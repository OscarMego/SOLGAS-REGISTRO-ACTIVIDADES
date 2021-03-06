﻿function makeSortable(sortable) {
    var tempItem = document.createElement('div');
    var dataType = 'list-item';
    var currentIndex = -1;

    for (var i = 0, n = sortable.children.length; i < n; i++) {
        var item = sortable.children.item(i);

        item.draggable = 'true';

        item.ondragstart = function (e) {
            currentIndex = getChildIndex(e.target);
            e.dataTransfer.setData(dataType, currentIndex);
            e.dataTransfer.effectAllowed = 'move';
        };

        item.ondragover = function (e) {
            var types = e.dataTransfer.types;

            if (types.contains) { // For FF.
                var canDrop = types.contains(dataType);
            } else if (types.indexOf) { // For Chrome and Safari.
                canDrop = types.indexOf(dataType) !== -1;
            }

            if (canDrop) {
                if (getChildIndex(e.target) !== currentIndex) {
                    e.dataTransfer.dropEffect = 'move';
                    e.preventDefault(); // Allows the drop.
                }
            }
        };

        item.ondrop = function (e) {
            var startIndex = +e.dataTransfer.getData(dataType);
            var startItem = sortable.children.item(startIndex);
            var endItem = e.target;
            var firstDIV = sortable.getElementsByTagName('div')[0];

            try {
                sortable.replaceChild(tempItem, endItem);
                sortable.replaceChild(endItem, startItem);
                sortable.replaceChild(startItem, tempItem);
                endItem.classList.remove('hover');

            } catch (err) {
                try {
                 
                    endItem = endItem.parentNode.parentNode;

                    sortable.replaceChild(tempItem, endItem);
                    sortable.replaceChild(endItem, startItem);
                    sortable.replaceChild(startItem, tempItem);
                    endItem.classList.remove('hover');
                } catch (err) {
                   
                }
            }
            e.preventDefault(); // For FF.
            return false; // For IE.
        };

        item.ondragenter = function (e) {
            if (e.target.nodeType === 1) { // FF raises event on text nodes?
                if (getChildIndex(e.target) !== currentIndex) {
                    e.target.classList.add('hover');
                }
            }
        };

        item.ondragleave = function (e) {
            if (e.target.nodeType === 1) { // FF raises event on text nodes?
                if (getChildIndex(e.target) !== currentIndex) {
                    e.target.classList.remove('hover');
                }
            }
        };
    }

    function getChildIndex(node) {
        var index = 0;
        while (node.previousSibling) {
            node = node.previousSibling;
            if (node.nodeType === 1) {
                index++;
            }
        }
        return index;
    }
}