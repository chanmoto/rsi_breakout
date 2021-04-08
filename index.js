'use strict';

const ht = require('http');
var fs = require('fs');

const sv = ht.createServer((req, res) => {
    fs.readFile('./index.html', 'utf-8',(data)=>{
    res.writeHead(200, {'Content-Type' : 'text/html'});
    res.write(data);
    res.end();
    })
});

const p = 8000;
sv.listen(p,()=>{
    console.log('listen on '+p);
})
