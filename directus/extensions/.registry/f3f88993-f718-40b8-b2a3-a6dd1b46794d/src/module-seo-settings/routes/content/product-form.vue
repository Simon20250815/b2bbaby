<template>
    <private-view smallHeader :title="isEdit ? 'Edit Product' : 'Create Product'">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ isEdit ? 'Edit Product' : 'Create Product' }}</h1>
                <div class="text-sm">{{ isEdit ? 'Modify product details' : 'Add a new product to your catalog' }}</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Save"
                @click="onSave"
                rounded
                icon
                :disabled="saving || loading"
                :loading="saving"
            >
                <v-icon name="check"></v-icon>
            </v-button>
        </template>
        <template #navigation>
            <navigator />
        </template>
        <div class="py-6 px-7.5 max-w-5xl">
            <div class="grid gap-6">
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Basic Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Title (English)</label>
                            <input 
                                v-model="formData.title" 
                                type="text" 
                                placeholder="Enter product title"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Slug</label>
                            <input 
                                v-model="formData.slug" 
                                type="text" 
                                placeholder="URL-friendly identifier"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Category</label>
                            <select 
                                v-model="formData.category"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary bg-white"
                            >
                                <option value="">Select category</option>
                                <option value="stroller">Stroller</option>
                                <option value="safety-gate">Safety Gate</option>
                                <option value="high-chair">High Chair</option>
                                <option value="bed-rail">Bed Rail</option>
                            </select>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">MOQ (pcs)</label>
                            <input 
                                v-model.number="formData.moq" 
                                type="number" 
                                min="1"
                                placeholder="Minimum order quantity"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Description</h2>
                    <div class="space-y-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Description (English)</label>
                            <textarea 
                                v-model="formData.description" 
                                rows="4"
                                placeholder="Enter product description"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Description (Chinese)</label>
                            <textarea 
                                v-model="formData.description_en" 
                                rows="4"
                                placeholder="中文描述"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Lead Time</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Sample Lead Time</label>
                            <input 
                                v-model="formData.lead_time_sample" 
                                type="text" 
                                placeholder="e.g., 3-7 days"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Production Lead Time</label>
                            <input 
                                v-model="formData.lead_time_production" 
                                type="text" 
                                placeholder="e.g., 15-25 days"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Certifications</h2>
                    <div class="space-y-3">
                        <div class="flex flex-wrap gap-2">
                            <span 
                                v-for="(cert, index) in formData.certifications" 
                                :key="index"
                                class="inline-flex items-center gap-1 px-3 py-1.5 bg-green-50 text-green-700 rounded-full text-sm"
                            >
                                {{ cert }}
                                <button @click="removeCert(index)" class="hover:text-green-900">
                                    <v-icon name="close" class="w-4 h-4" />
                                </button>
                            </span>
                        </div>
                        <div class="flex gap-2">
                            <input 
                                v-model="newCert" 
                                type="text" 
                                placeholder="Add certification (e.g., ASTM F833)"
                                class="flex-1 px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                                @keyup.enter="addCert"
                            />
                            <v-button secondary @click="addCert">Add</v-button>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Status</h2>
                    <div class="flex items-center gap-4">
                        <label class="flex items-center gap-2 cursor-pointer">
                            <input 
                                v-model="formData.status" 
                                type="radio" 
                                value="published"
                                class="w-4 h-4 text-primary"
                            />
                            <span class="text-sm text-slate-700">Published</span>
                        </label>
                        <label class="flex items-center gap-2 cursor-pointer">
                            <input 
                                v-model="formData.status" 
                                type="radio" 
                                value="draft"
                                class="w-4 h-4 text-primary"
                            />
                            <span class="text-sm text-slate-700">Draft</span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </private-view>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useApi, useStores } from '@directus/extensions-sdk';
import Navigator from '../../components/navigator/index.vue';

const route = useRoute();
const router = useRouter();
const api = useApi();
const { useNotificationsStore } = useStores();
const notify = useNotificationsStore();

const isEdit = computed(() => !!route.params.id);
const loading = ref(false);
const saving = ref(false);
const newCert = ref('');

const formData = reactive({
    title: '',
    slug: '',
    category: '',
    description: '',
    description_en: '',
    moq: 50,
    lead_time_sample: '',
    lead_time_production: '',
    certifications: [] as string[],
    status: 'draft'
});

function addCert() {
    if (newCert.value.trim()) {
        formData.certifications.push(newCert.value.trim());
        newCert.value = '';
    }
}

function removeCert(index: number) {
    formData.certifications.splice(index, 1);
}

async function loadProduct() {
    if (!isEdit.value) return;
    
    loading.value = true;
    try {
        const response = await api.get(`/items/products/${route.params.id}`);
        const data = response.data.data;
        formData.title = data.title || '';
        formData.slug = data.slug || '';
        formData.category = data.category || '';
        formData.description = data.description || '';
        formData.description_en = data.description_en || '';
        formData.moq = data.moq || 50;
        formData.lead_time_sample = data.lead_time_sample || '';
        formData.lead_time_production = data.lead_time_production || '';
        formData.certifications = data.certifications || [];
        formData.status = data.status || 'draft';
    } catch (error) {
        console.error('Failed to load product:', error);
        notify.add({ title: 'Error loading product', type: 'error' });
    }
    loading.value = false;
}

async function onSave() {
    saving.value = true;
    try {
        const payload = {
            ...formData,
            slug: formData.slug || formData.title.toLowerCase().replace(/\s+/g, '-')
        };

        if (isEdit.value) {
            await api.patch(`/items/products/${route.params.id}`, payload);
            notify.add({ title: 'Product updated successfully' });
        } else {
            await api.post('/items/products', payload);
            notify.add({ title: 'Product created successfully' });
        }
        
        router.push('/seo-settings/content/products');
    } catch (error) {
        console.error('Failed to save product:', error);
        notify.add({ title: 'Error saving product', type: 'error' });
    }
    saving.value = false;
}

onMounted(() => {
    loadProduct();
});
</script>