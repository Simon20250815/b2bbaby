import { defineModule } from '@directus/extensions-sdk';
import RoutePass from '../shared/utils/router-passthrough'
import SiteBasic from './routes/general/site-basic.vue';
import LocalSEO from './routes/general/local-seo.vue';
import TitleMeta from './routes/general/title-meta.vue';
import TitleMetaDetail from './routes/general/title-meta-detail-new.vue';
import Scripts from './routes/advanced/scripts.vue';
import Setup from './routes/setup/setup.vue';
import SetupWizard from './routes/setup/setup-wizard.vue';
import Empty from './routes/empty.vue';
import Products from './routes/content/products.vue';
import ProductForm from './routes/content/product-form.vue';
import Blogs from './routes/content/blogs.vue';
import BlogForm from './routes/content/blog-form.vue';
import FAQs from './routes/content/faqs.vue';
import FAQForm from './routes/content/faq-form.vue';
import '../styles/base.scss'
import '../styles/form.scss'

export default defineModule({
	id: 'seo-settings',
    name: 'SEO settings',
    icon: 'area_chart',
	routes: [
        {
            name: 'seo-content',
            path: '/seo-settings/content',
            component: RoutePass,
            children: [
                {
                    name: 'seo-content-products',
                    path: 'products',
                    component: Products,
                },
                {
                    name: 'seo-content-products-create',
                    path: 'products/create',
                    component: ProductForm,
                },
                {
                    name: 'seo-content-products-edit',
                    path: 'products/:id/edit',
                    component: ProductForm,
                },
                {
                    name: 'seo-content-blogs',
                    path: 'blogs',
                    component: Blogs,
                },
                {
                    name: 'seo-content-blogs-create',
                    path: 'blogs/create',
                    component: BlogForm,
                },
                {
                    name: 'seo-content-blogs-edit',
                    path: 'blogs/:id/edit',
                    component: BlogForm,
                },
                {
                    name: 'seo-content-faqs',
                    path: 'faqs',
                    component: FAQs,
                },
                {
                    name: 'seo-content-faqs-create',
                    path: 'faqs/create',
                    component: FAQForm,
                },
                {
                    name: 'seo-content-faqs-edit',
                    path: 'faqs/:id/edit',
                    component: FAQForm,
                },
            ]
        },
        {
            name: 'seo-settings',
            path: '/seo-settings',
            component: RoutePass,
            beforeEnter(to) {
                if( to.name === 'seo-settings' ) {

                    console.log(to)
                    return {
                        name: 'seo-title-meta',
                        path: 'title-meta',
                    }
                }
            },
            children: [
                {
                    name: 'seo-settings',
                    path: '',
                    component: TitleMeta,
                },
                {
                    name: 'seo-title-meta',
                    path: 'title-meta',
                    component: TitleMeta,
                },
                {
                    name: 'seo-title-meta-detail',
                    path: 'title-meta/:collection',
                    component: TitleMetaDetail,
                },
                {
                    name: 'seo-site-basic',
                    path: 'site-basic',
                    component: SiteBasic,
                },
                {
                    name: 'seo-local-seo',
                    path: 'local-seo',
                    component: LocalSEO,
                },
            ]
        },
        {
            name: 'seo-advanced-scripts',
            path: '/seo-settings/advanced/scripts',
            component: RoutePass,
            children: [
                {
                    name: 'seo-advanced-scripts',
                    path: '',
                    component: Scripts,
                },
            ]
        },
		{
            name: 'seo-setup',
            path: '/seo-settings/setup',
            component: Setup,
        },
        {
            name: 'seo-setup-wizard',
            path: '/seo-settings/setup-wizard',
            component: SetupWizard,
        },
		
	],
});
