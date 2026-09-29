import {mkdir,cp,rm,readFile,writeFile} from 'node:fs/promises';
await rm('dist',{recursive:true,force:true});await mkdir('dist');
for(const file of ['index.html','style.css','app.js','cloud.js','config.js','assets','data'])await cp(file,'dist/'+file,{recursive:true});
