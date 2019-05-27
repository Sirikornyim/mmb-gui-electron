function tojson(modelbase, path)
  keyvariables = [ 'inflation'; 'interest '; 'output   ';'outputgap'];

  model_id = 1;
  rule_id = 1;
  
  outputmodel = struct(...
  'model', {},...
  'rule', {},...
  'shock', {},...
  'func', {},...
  'outputvar', {},...
  'values', {}...
  );
  
  if modelbase.option(1)==1
    for pp=1:4
              autmod = deblank(strtrim(modelbase.names(model_id,:)));
              autrule = deblank(modelbase.rulenamesshort1(rule_id,:));
              autvar = keyvariables(pp,:);
      if isfield(modelbase, 'AUTendo_names') & isfield(modelbase.AUTendo_names, deblank(autrule))
          if loc(modelbase.AUTendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:))~=0
               %eval('AUTval = modelbase.AUTR.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.AUTendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),:);');
              AUTval = modelbase.AUTR.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.AUTendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),:);
              if max(isnan(AUTval))==0
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(autmod),...
                  'rule', deblank(autrule),...
                  'shock', [],...
                  'func', 'AC',...
                  'outputvar', deblank(autvar),...
                  'values', AUTval...
              ));
              else
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(autmod),...
                  'rule', deblank(autrule),...
                  'shock', [],...
                  'func', 'AC',...
                  'outputvar', deblank(autvar),...
                  'values', []...
              ));
              end
          else
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(autmod),...
                  'rule', deblank(autrule),...
                  'shock', [],...
                  'func', 'AC',...
                  'outputvar', deblank(autvar),...
                  'values', []...
              ));
          end
            else
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(autmod),...
                  'rule', deblank(autrule),...
                  'shock', [],...
                  'func', 'AC',...
                  'outputvar', deblank(autvar),...
                  'values', []...
              ));
      end
                       end
                    
                    
  for pp=1:4
              vmod = deblank(strtrim(modelbase.names(model_id,:)));
              vrule = deblank(modelbase.rulenamesshort1(rule_id,:));
              vname = keyvariables(pp,:);
         if isfield (modelbase,'VARendo_names')& isfield(modelbase.VARendo_names, deblank(vrule))
              if loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:))~=0
              var = modelbase.VAR.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)));
              %eval('VARval = modelbase.VAR.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)));');
              VARval = modelbase.VAR.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),loc(modelbase.VARendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)));
              if max(isnan(VARval))==0
                  outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(vmod),...
                  'rule', deblank(vrule),...
                  'shock', [],...
                  'func', 'VAR',...
                  'outputvar', deblank(vname),...
                  'values', VARval...
                   ));
              else
             outputmodel = horzcat(outputmodel, struct(...
                 'model', deblank(vmod),...
                 'rule', deblank(vrule),...
                 'shock', [],...
                 'func', 'VAR',...
                 'outputvar', deblank(vname),...
                 'values', []...
                  ));
              end
              else
             outputmodel = horzcat(outputmodel, struct(...
                 'model', deblank(vmod),...
                 'rule', deblank(vrule),...
                 'shock', [],...
                 'func', 'VAR',...
                 'outputvar', deblank(vname),...
                 'values', []...
                  ));
              end
         else
             outputmodel = horzcat(outputmodel, struct(...
                 'model', deblank(vmod),...
                 'rule', deblank(vrule),...
                 'shock', [],...
                 'func', 'VAR',...
                 'outputvar', deblank(vname),...
                 'values', []...
             ));
         end
  end
                    
                    
                       for p=1:size(modelbase.innos,1)
     irfmod = deblank(strtrim(modelbase.names(model_id,:)));
     irfrule = deblank(modelbase.rulenamesshort1(rule_id,:));
     irfshock = (deblank(modelbase.namesshocks(p,1:3)));
     for pp=1:4
          irfvar = keyvariables(pp,:);
              if  modelbase.pos_shock(p,model_id)~=0
              irfvar = keyvariables(pp,:);
              if isfield (modelbase,'IRFendo_names')& isfield(modelbase.IRFendo_names, deblank(irfrule))
              if loc(modelbase.IRFendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:))~=0
                  IRFval = modelbase.IRF.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:))))(loc(modelbase.IRFendo_names.(strtrim(deblank(modelbase.rulenamesshort1(rule_id,:)))),keyvariables(pp,:)),:,p);

                  outputmodel = horzcat(outputmodel, struct(...
                      'model', deblank(irfmod),...
                      'rule', deblank(irfrule),...
                      'shock', irfshock,...
                      'func', 'IRF',...
                      'outputvar', deblank(irfvar),...
                      'values', IRFval...
                  ));
              else
                  outputmodel = horzcat(outputmodel, struct(...
                      'model', deblank(irfmod),...
                      'rule', deblank(irfrule),...
                      'shock', irfshock,...
                      'func', 'IRF',...
                      'outputvar', deblank(irfvar),...
                      'values', []...
                  ));
              end
              else
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(irfmod),...
                  'rule', deblank(irfrule),...
                  'shock', irfshock,...
                  'func', 'IRF',...
                  'outputvar', deblank(irfvar),...
                  'values', []...
              ));
              end
              else
              outputmodel = horzcat(outputmodel, struct(...
                  'model', deblank(irfmod),...
                  'rule', deblank(irfrule),...
                  'shock', irfshock,...
                  'func', 'IRF',...
                  'outputvar', deblank(irfvar),...
                  'values', []...
              ));
      end
    end
  end

  [folder] = fileparts(path);
  mkdir(folder);
  savejson('', outputmodel, path);
end 