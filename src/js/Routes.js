Ext.define('TualoOffice.routes.CMS',{
    url: 'cms',
    handler: {
        action: function(token){
            console.log('onAnyRoute',token);
            alert('cms','ok');
        },
        before: function (action) {
            console.log('onBeforeToken',action);
            console.log(new Date());
            action.resume();
        }
    }
});